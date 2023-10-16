Globals.SpellLists = {}
DictUtils = {}

local function setupSpellListDict()
  local result = {
    Cantrips = {},
    Spells = {}
  }

  return result
end

function DictUtils.SpellList(name, subType)
  subType = subType or {}

  Globals.SpellLists[name] = {
    Base = setupSpellListDict()
  }

  if subType ~= nil then
    for _, val in pairs(subType) do
      Globals.SpellLists[name][val] = setupSpellListDict()
    end
  end

  return Globals.SpellLists[name]
end

function DictUtils.InsertField(obj, fieldObj)
  obj = obj or {}
  for key, value in pairs(fieldObj) do
    obj[key] = value
  end
end