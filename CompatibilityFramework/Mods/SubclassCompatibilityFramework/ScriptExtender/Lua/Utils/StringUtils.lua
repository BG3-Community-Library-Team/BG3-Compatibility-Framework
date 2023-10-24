function Utils.IsInString(str, value)
  return string.find(str, value)
end

function Utils.IsGuid(string)
  local x = "%x"
  local t = { x:rep(8), x:rep(4), x:rep(4), x:rep(4), x:rep(12) }
  local pattern = table.concat(t, '%-')

  return string:match(pattern)
end
