function DictUtils.setupClassLevelEntry(progression, mcProgression)
  local result = {}
  result.Progression = progression
  result.MulticlassProgression = mcProgression or nil

  return result
end

local function setupProgressionDict()
  return {
    Level = {}
  }
end

function DictUtils.ClassProgression(name, subType)
  subType = subType or {}

  Globals.SpellLists[name] = {
    Base = setupProgressionDict()
  }

  if subType ~= nil then
    for _, val in pairs(subType) do
      Globals.Progressions[name][val] = setupProgressionDict()
    end
  end

  return Globals.Progressions[name]
end
