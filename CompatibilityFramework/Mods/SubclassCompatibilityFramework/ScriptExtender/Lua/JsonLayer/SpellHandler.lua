function JsonUtils.BuildSpellStringPayload(spells, target, modGuid, stringType)
  Utils.Info("Entering BuildSpellStringPayload")
  return {
    modGuid = modGuid,
    Target = target,
    SubSpells = spells,
    Type = stringType
  }
end

function JsonUtils.ParseAndSubmitSpellStrings(spells, target, modGuid, stringType, action)
  Utils.Info("Entering ParseAndSubmitSpellStrings")
  local payloads = {
    Insert = JsonUtils.BuildSpellStringPayload(spells, target, modGuid, stringType),
    Remove = JsonUtils.BuildSpellStringPayload(spells, target, modGuid, stringType)
  }

  if payloads[action] ~= nil then
    JsonUtils.Endpoints[action][stringType]({ payloads[action] })
  end
end

function SpellSubsectionHandler(data, modGuid)
  modGuid = data.modGuid or modGuid
  if data.ContainerSpells ~= nil then
    JsonUtils.ParseAndSubmitSpellStrings(data.ContainerSpells, data.ID, modGuid, "ContainerSpells", data.Action)
  end
end

function SpellJsonHandler(data, modGuid)
  Utils.Info("Entering SpellJsonHandler")
  for _, spell in pairs(data) do
    SpellSubsectionHandler(spell, modGuid)
  end
end
