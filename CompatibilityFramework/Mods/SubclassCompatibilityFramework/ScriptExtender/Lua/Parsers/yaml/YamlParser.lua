--- YamlParser.lua — Minimal YAML subset parser for Compatibility Framework
--- Produces a Lua table identical to what Ext.Json.Parse would return from the equivalent JSON.
---
--- Supported: block mappings, block sequences, flow sequences/mappings, quoted & unquoted scalars,
---            integers, booleans (true/false only), null (~), comments (#), anchors (&) / aliases (*).
--- Not supported: multi-line strings, tags, directives, multi-document, yes/no/on/off booleans.

-------------------------------------------------
-- Utilities
-------------------------------------------------

--- Deep-copy a value. Tables are recursively copied; scalars are returned as-is.
---@param val any
---@return any
local function deepCopy(val)
  if type(val) ~= "table" then return val end
  local copy = {}
  for k, v in pairs(val) do
    copy[deepCopy(k)] = deepCopy(v)
  end
  return copy
end

-------------------------------------------------
-- Anchor Store
-------------------------------------------------

---@class AnchorStore
---@field anchors table<string, any>
local AnchorStore = {}
AnchorStore.__index = AnchorStore

function AnchorStore.new()
  return setmetatable({ anchors = {} }, AnchorStore)
end

---@param name string
---@param value any
---@param lineNum number
function AnchorStore:set(name, value, lineNum)
  if self.anchors[name] ~= nil then
    CLUtils.Warn(Strings.PREFIX .. Strings.WARN_YAML_ANCHOR_REDEF
      .. "'" .. name .. "' (line " .. lineNum .. ")")
  end
  self.anchors[name] = deepCopy(value)
end

---@param name string
---@param lineNum number
---@return any
function AnchorStore:get(name, lineNum)
  local val = self.anchors[name]
  if val == nil then
    error(Strings.ERR_YAML_UNDEFINED_ALIAS .. "'" .. name .. "' (line " .. lineNum .. ")")
  end
  return deepCopy(val)
end

-------------------------------------------------
-- Anchor / Alias extraction helpers
-------------------------------------------------

--- Extract an anchor definition from the beginning of a value string.
---@param str string  The value portion after "key: " or "- "
---@return string|nil anchorName
---@return string remainingStr
local function extractAnchor(str)
  -- "&name value" — anchor with inline value
  local name, rest = str:match("^&([%w_%-]+)%s+(.+)$")
  if name then return name, rest end
  -- "&name" — anchor with block value on following lines
  name = str:match("^&([%w_%-]+)$")
  if name then return name, "" end
  return nil, str
end

--- Extract an alias reference.
---@param str string
---@return string|nil aliasName
local function extractAlias(str)
  return str:match("^%*([%w_%-]+)$")
end

-------------------------------------------------
-- Scalar Parser
-------------------------------------------------

--- Unescape common double-quoted escape sequences.
---@param s string
---@return string
local function unescapeDoubleQuoted(s)
  s = s:gsub("\\\\", "\x00BACKSLASH\x00")
  s = s:gsub('\\"', '"')
  s = s:gsub("\\n", "\n")
  s = s:gsub("\\t", "\t")
  s = s:gsub("\x00BACKSLASH\x00", "\\")
  return s
end

--- Parse a scalar string into a typed Lua value.
---@param str string
---@return any
local function parseScalar(str)
  if str == nil then return nil end
  -- Trim whitespace
  str = str:match("^%s*(.-)%s*$")

  -- Null
  if str == "" or str == "~" or str == "null" then return nil end

  -- Boolean (strict — only true/false, never yes/no/on/off)
  if str == "true" then return true end
  if str == "false" then return false end

  -- Integer
  if str:match("^%-?%d+$") then return tonumber(str) end

  -- Double-quoted string
  if str:sub(1, 1) == '"' then
    local dq = str:match('^"(.*)"$')
    if dq then return unescapeDoubleQuoted(dq) end
    error(Strings.ERR_YAML_UNTERMINATED_STR)
  end

  -- Single-quoted string
  if str:sub(1, 1) == "'" then
    local sq = str:match("^'(.*)'$")
    if sq then return sq:gsub("''", "'") end
    error(Strings.ERR_YAML_UNTERMINATED_STR)
  end

  -- Bare string
  return str
end

-------------------------------------------------
-- Comment stripping (quote-aware)
-------------------------------------------------

--- Strip an inline comment from a content string, respecting quoted regions.
---@param str string
---@return string
local function stripInlineComment(str)
  local inSingle = false
  local inDouble = false
  local i = 1
  local len = #str
  while i <= len do
    local c = str:sub(i, i)
    if c == "\\" and inDouble then
      i = i + 2  -- skip escaped character
    elseif c == '"' and not inSingle then
      inDouble = not inDouble
      i = i + 1
    elseif c == "'" and not inDouble then
      inSingle = not inSingle
      i = i + 1
    elseif c == "#" and not inSingle and not inDouble then
      -- Must be preceded by whitespace (or be at position 1) to be a comment
      if i == 1 or str:sub(i - 1, i - 1) == " " then
        return str:sub(1, i - 1):gsub("%s+$", "")
      end
      i = i + 1
    else
      i = i + 1
    end
  end
  return str
end

-------------------------------------------------
-- Line Preprocessor
-------------------------------------------------

---@class YamlLine
---@field num number
---@field indent number
---@field content string

--- Split raw YAML text into a list of preprocessed line records.
---@param raw string
---@return YamlLine[]
local function preprocessLines(raw)
  local lines = {}
  local lineNum = 0
  for line in (raw .. "\n"):gmatch("([^\n]*)\n") do
    lineNum = lineNum + 1
    line = line:gsub("\r$", "")

    -- Reject tabs in indentation
    if line:match("^\t") then
      error(Strings.ERR_YAML_TAB_INDENT .. " (line " .. lineNum .. ")")
    end

    local indent = #(line:match("^( *)") or "")
    local content = line:sub(indent + 1)

    -- Strip trailing whitespace first, then inline comments
    content = content:gsub("%s+$", "")
    content = stripInlineComment(content)
    content = content:gsub("%s+$", "")

    -- Skip blank / comment-only lines
    if content ~= "" and content:sub(1, 1) ~= "#" then
      table.insert(lines, { num = lineNum, indent = indent, content = content })
    end
  end
  return lines
end

-------------------------------------------------
-- Flow Parser
-------------------------------------------------

-- Forward declarations
local parseFlowValue

--- Skip whitespace in a string starting at position pos.
---@param str string
---@param pos number
---@return number
local function skipWS(str, pos)
  while pos <= #str and (str:sub(pos, pos) == " " or str:sub(pos, pos) == "\t") do
    pos = pos + 1
  end
  return pos
end

--- Read a quoted string from a flow context, returning the parsed value and next position.
---@param str string
---@param pos number  Position of the opening quote character
---@return string value
---@return number nextPos
local function readFlowQuotedString(str, pos)
  local quote = str:sub(pos, pos)  -- ' or "
  local start = pos + 1
  local i = start
  local parts = {}
  while i <= #str do
    local c = str:sub(i, i)
    if c == "\\" and quote == '"' then
      table.insert(parts, str:sub(start, i - 1))
      i = i + 1
      local esc = str:sub(i, i)
      if esc == "n" then table.insert(parts, "\n")
      elseif esc == "t" then table.insert(parts, "\t")
      elseif esc == "\\" then table.insert(parts, "\\")
      elseif esc == '"' then table.insert(parts, '"')
      else table.insert(parts, esc) end
      i = i + 1
      start = i
    elseif c == "'" and quote == "'" and str:sub(i + 1, i + 1) == "'" then
      -- Escaped single quote in single-quoted string
      table.insert(parts, str:sub(start, i))  -- include one '
      i = i + 2
      start = i
    elseif c == quote then
      table.insert(parts, str:sub(start, i - 1))
      return table.concat(parts), i + 1
    else
      i = i + 1
    end
  end
  error(Strings.ERR_YAML_UNTERMINATED_STR)
end

--- Read a bare (unquoted) scalar in flow context — stops at , ] } :
---@param str string
---@param pos number
---@return string value
---@return number nextPos
local function readFlowBareValue(str, pos)
  local start = pos
  while pos <= #str do
    local c = str:sub(pos, pos)
    if c == "," or c == "]" or c == "}" or c == ":" then
      break
    end
    pos = pos + 1
  end
  local raw = str:sub(start, pos - 1):gsub("%s+$", "")
  return raw, pos
end

--- Parse a flow sequence: [val, val, ...]
---@param str string
---@param pos number  Position of '['
---@param anchorStore AnchorStore
---@param lineNum number
---@return table result
---@return number nextPos
local function parseFlowSequence(str, pos, anchorStore, lineNum)
  local result = {}
  pos = pos + 1  -- skip '['
  pos = skipWS(str, pos)
  while pos <= #str and str:sub(pos, pos) ~= "]" do
    -- Check for alias
    if str:sub(pos, pos) == "*" then
      local nameEnd = pos + 1
      while nameEnd <= #str and str:sub(nameEnd, nameEnd):match("[%w_%-]") do
        nameEnd = nameEnd + 1
      end
      local aliasName = str:sub(pos + 1, nameEnd - 1)
      table.insert(result, anchorStore:get(aliasName, lineNum))
      pos = nameEnd
    -- Check for anchor
    elseif str:sub(pos, pos) == "&" then
      local nameEnd = pos + 1
      while nameEnd <= #str and str:sub(nameEnd, nameEnd):match("[%w_%-]") do
        nameEnd = nameEnd + 1
      end
      local anchorName = str:sub(pos + 1, nameEnd - 1)
      pos = skipWS(str, nameEnd)
      local val
      val, pos = parseFlowValue(str, pos, anchorStore, lineNum)
      anchorStore:set(anchorName, val, lineNum)
      table.insert(result, val)
    else
      local val
      val, pos = parseFlowValue(str, pos, anchorStore, lineNum)
      table.insert(result, val)
    end
    pos = skipWS(str, pos)
    if pos <= #str and str:sub(pos, pos) == "," then
      pos = pos + 1
      pos = skipWS(str, pos)
    end
  end
  if pos <= #str then pos = pos + 1 end  -- skip ']'
  return result, pos
end

--- Parse a flow mapping: {key: val, key: val, ...}
---@param str string
---@param pos number  Position of '{'
---@param anchorStore AnchorStore
---@param lineNum number
---@return table result
---@return number nextPos
local function parseFlowMapping(str, pos, anchorStore, lineNum)
  local result = {}
  pos = pos + 1  -- skip '{'
  pos = skipWS(str, pos)
  while pos <= #str and str:sub(pos, pos) ~= "}" do
    -- Read key
    local key
    local c = str:sub(pos, pos)
    if c == '"' or c == "'" then
      key, pos = readFlowQuotedString(str, pos)
    else
      key, pos = readFlowBareValue(str, pos)
    end
    pos = skipWS(str, pos)
    -- Expect ':'
    if pos <= #str and str:sub(pos, pos) == ":" then
      pos = pos + 1
      pos = skipWS(str, pos)
    end
    -- Read value — check alias/anchor
    local val
    if pos <= #str and str:sub(pos, pos) == "*" then
      local nameEnd = pos + 1
      while nameEnd <= #str and str:sub(nameEnd, nameEnd):match("[%w_%-]") do
        nameEnd = nameEnd + 1
      end
      local aliasName = str:sub(pos + 1, nameEnd - 1)
      val = anchorStore:get(aliasName, lineNum)
      pos = nameEnd
    elseif pos <= #str and str:sub(pos, pos) == "&" then
      local nameEnd = pos + 1
      while nameEnd <= #str and str:sub(nameEnd, nameEnd):match("[%w_%-]") do
        nameEnd = nameEnd + 1
      end
      local anchorName = str:sub(pos + 1, nameEnd - 1)
      pos = skipWS(str, nameEnd)
      val, pos = parseFlowValue(str, pos, anchorStore, lineNum)
      anchorStore:set(anchorName, val, lineNum)
    else
      val, pos = parseFlowValue(str, pos, anchorStore, lineNum)
    end
    result[key] = val
    pos = skipWS(str, pos)
    if pos <= #str and str:sub(pos, pos) == "," then
      pos = pos + 1
      pos = skipWS(str, pos)
    end
  end
  if pos <= #str then pos = pos + 1 end  -- skip '}'
  return result, pos
end

--- Parse a single flow value (scalar, nested sequence, or nested mapping).
---@param str string
---@param pos number
---@param anchorStore AnchorStore
---@param lineNum number
---@return any value
---@return number nextPos
parseFlowValue = function(str, pos, anchorStore, lineNum)
  pos = skipWS(str, pos)
  if pos > #str then return nil, pos end
  local c = str:sub(pos, pos)
  if c == "[" then
    return parseFlowSequence(str, pos, anchorStore, lineNum)
  elseif c == "{" then
    return parseFlowMapping(str, pos, anchorStore, lineNum)
  elseif c == '"' or c == "'" then
    local raw
    raw, pos = readFlowQuotedString(str, pos)
    -- We must return the properly typed value; for quoted strings in flow it's always a string
    return raw, pos
  else
    local raw
    raw, pos = readFlowBareValue(str, pos)
    return parseScalar(raw), pos
  end
end

-------------------------------------------------
-- Block Parser
-------------------------------------------------

-- Forward declarations
local parseMapping, parseSequence, parseBlock, parseCompactMapping

--- Determine if a content line looks like a mapping key (key: ...) vs a sequence item (- ...).
---@param content string
---@return boolean isMapping
local function looksLikeMapping(content)
  -- Sequence items start with "- "
  if content:sub(1, 2) == "- " or content == "-" then return false end
  -- Mapping keys match "word:" with optional value
  if content:match("^[%w_][%w_%.-]*:%s") or content:match("^[%w_][%w_%.-]*:$") then return true end
  return false
end

--- Parse a block mapping. The anchorStore is threaded through for anchor/alias resolution.
---@param lines YamlLine[]
---@param idx number
---@param baseIndent number
---@param anchorStore AnchorStore
---@return table result
---@return number nextIdx
parseMapping = function(lines, idx, baseIndent, anchorStore)
  local result = {}
  while idx <= #lines and lines[idx].indent == baseIndent do
    local line = lines[idx]
    local content = line.content

    -- Match "key: rest" or "key:"
    local key, rest = content:match("^([%w_][%w_%.-]*):%s*(.*)")
    if not key then
      -- If we hit a non-mapping line at the same indent, we're done with this mapping
      break
    end

    if rest ~= "" then
      -- Check for alias
      local aliasName = extractAlias(rest)
      if aliasName then
        result[key] = anchorStore:get(aliasName, line.num)
        idx = idx + 1
      else
        -- Check for anchor
        local anchorName, strippedRest = extractAnchor(rest)

        local value
        if strippedRest == "" then
          -- Anchor with no inline value — block follows
          if idx + 1 <= #lines and lines[idx + 1].indent > baseIndent then
            value, idx = parseBlock(lines, idx + 1, lines[idx + 1].indent, anchorStore)
          else
            value = nil
            idx = idx + 1
          end
        elseif strippedRest:sub(1, 1) == "[" then
          value = parseFlowSequence(strippedRest, 1, anchorStore, line.num)
          idx = idx + 1
        elseif strippedRest:sub(1, 1) == "{" then
          value = parseFlowMapping(strippedRest, 1, anchorStore, line.num)
          idx = idx + 1
        else
          value = parseScalar(strippedRest)
          idx = idx + 1
        end

        if anchorName then
          anchorStore:set(anchorName, value, line.num)
        end
        result[key] = value
      end
    else
      -- No inline value — look for block on next line(s)
      if idx + 1 <= #lines and lines[idx + 1].indent > baseIndent then
        result[key], idx = parseBlock(lines, idx + 1, lines[idx + 1].indent, anchorStore)
      else
        result[key] = nil
        idx = idx + 1
      end
    end
  end
  return result, idx
end

--- Parse a block sequence.
---@param lines YamlLine[]
---@param idx number
---@param baseIndent number
---@param anchorStore AnchorStore
---@return table result
---@return number nextIdx
parseSequence = function(lines, idx, baseIndent, anchorStore)
  local result = {}
  while idx <= #lines and lines[idx].indent == baseIndent do
    local line = lines[idx]
    local content = line.content

    -- Must start with "- "
    local rest = content:match("^-%s*(.*)")
    if not rest then break end  -- no longer a sequence item at this indent

    if rest == "" then
      -- Bare "- " with value on next line(s)
      if idx + 1 <= #lines and lines[idx + 1].indent > baseIndent then
        local val
        val, idx = parseBlock(lines, idx + 1, lines[idx + 1].indent, anchorStore)
        table.insert(result, val)
      else
        table.insert(result, nil)
        idx = idx + 1
      end

    elseif extractAlias(rest) then
      -- "- *aliasName"
      local aliasName = extractAlias(rest)
      table.insert(result, anchorStore:get(aliasName, line.num))
      idx = idx + 1

    elseif rest:sub(1, 1) == "&" then
      -- "- &anchorName ..." or "- &anchorName" (block follows)
      local anchorName, strippedRest = extractAnchor(rest)
      local val
      if strippedRest == "" then
        -- Block follows on next line
        if idx + 1 <= #lines and lines[idx + 1].indent > baseIndent then
          val, idx = parseBlock(lines, idx + 1, lines[idx + 1].indent, anchorStore)
        else
          val = nil
          idx = idx + 1
        end
      elseif strippedRest:sub(1, 1) == "[" then
        val = parseFlowSequence(strippedRest, 1, anchorStore, line.num)
        idx = idx + 1
      elseif strippedRest:sub(1, 1) == "{" then
        val = parseFlowMapping(strippedRest, 1, anchorStore, line.num)
        idx = idx + 1
      elseif strippedRest:match("^[%w_][%w_%.-]*:%s") or strippedRest:match("^[%w_][%w_%.-]*:$") then
        -- Compact mapping with anchor on "- " line: "- &name Key: value"
        -- This is unusual but we handle it
        val, idx = parseCompactMapping(lines, idx, baseIndent, strippedRest, anchorStore)
      else
        val = parseScalar(strippedRest)
        idx = idx + 1
      end
      if anchorName then
        anchorStore:set(anchorName, val, line.num)
      end
      table.insert(result, val)

    elseif rest:match("^[%w_][%w_%.-]*:%s") or rest:match("^[%w_][%w_%.-]*:$") then
      -- Compact mapping: "- Key: value" possibly continuing on next lines
      local val
      val, idx = parseCompactMapping(lines, idx, baseIndent, rest, anchorStore)
      table.insert(result, val)

    elseif rest:sub(1, 1) == "[" then
      local val = parseFlowSequence(rest, 1, anchorStore, line.num)
      table.insert(result, val)
      idx = idx + 1

    elseif rest:sub(1, 1) == "{" then
      local val = parseFlowMapping(rest, 1, anchorStore, line.num)
      table.insert(result, val)
      idx = idx + 1

    else
      -- Plain scalar
      table.insert(result, parseScalar(rest))
      idx = idx + 1
    end
  end
  return result, idx
end

--- Parse a compact mapping that starts on a sequence "- " line.
--- e.g. "- UUID: abc123\n    SubClassName: Oathbreaker"
--- The first key:value pair is provided in `firstContent`.
--- Subsequent lines at indent(dashLine) + 2 (or more precisely, aligned with the key)
--- belong to the same mapping.
---@param lines YamlLine[]
---@param dashIdx number  Index of the "- key: value" line
---@param seqIndent number  Indent of the "-" character
---@param firstContent string  Everything after "- " on the dash line
---@param anchorStore AnchorStore
---@return table result
---@return number nextIdx
parseCompactMapping = function(lines, dashIdx, seqIndent, firstContent, anchorStore)
  local line = lines[dashIdx]
  -- The mapping keys after the first line align at seqIndent + 2
  -- (the "- " consumes 2 characters of indent)
  local mappingIndent = seqIndent + 2

  -- Build a virtual line for the first key:value from the "- " line
  local virtualLine = { num = line.num, indent = mappingIndent, content = firstContent }

  -- Collect continuation lines that are at mappingIndent
  local subLines = { virtualLine }
  local nextIdx = dashIdx + 1
  while nextIdx <= #lines and lines[nextIdx].indent >= mappingIndent do
    if lines[nextIdx].indent == mappingIndent then
      -- Same level as the mapping keys — part of this compact mapping
      -- But only if it looks like a mapping key, not another "- " at seqIndent
      table.insert(subLines, lines[nextIdx])
      nextIdx = nextIdx + 1
    elseif lines[nextIdx].indent > mappingIndent then
      -- Deeper indent — child of a key in this mapping; include it
      table.insert(subLines, lines[nextIdx])
      nextIdx = nextIdx + 1
    else
      break
    end
  end

  -- Parse the collected lines as a mapping
  local result, _ = parseMapping(subLines, 1, mappingIndent, anchorStore)
  return result, nextIdx
end

--- Top-level block dispatcher: determines if the next block is a mapping or sequence
--- and delegates accordingly.
---@param lines YamlLine[]
---@param idx number
---@param baseIndent number
---@param anchorStore AnchorStore
---@return any result
---@return number nextIdx
parseBlock = function(lines, idx, baseIndent, anchorStore)
  if idx > #lines then return nil, idx end

  local content = lines[idx].content
  if looksLikeMapping(content) then
    return parseMapping(lines, idx, baseIndent, anchorStore)
  else
    return parseSequence(lines, idx, baseIndent, anchorStore)
  end
end

-------------------------------------------------
-- Entry Point & Adapter
-------------------------------------------------

--- Parse a raw YAML string into a Lua table.
---@param raw string
---@return table
local function yamlParse(raw)
  if type(raw) ~= "string" then
    error("YamlParser.parse: expected string, got " .. type(raw))
  end

  local lines = preprocessLines(raw)
  if #lines == 0 then return {} end

  local anchorStore = AnchorStore.new()
  local result, _ = parseBlock(lines, 1, lines[1].indent, anchorStore)
  return result or {}
end

--- Expose globally for direct use and testing
YamlParser = {
  parse = yamlParse,
  -- Expose internals for unit testing
  _internal = {
    deepCopy = deepCopy,
    parseScalar = parseScalar,
    stripInlineComment = stripInlineComment,
    preprocessLines = preprocessLines,
    AnchorStore = AnchorStore,
    extractAnchor = extractAnchor,
    extractAlias = extractAlias,
  }
}
