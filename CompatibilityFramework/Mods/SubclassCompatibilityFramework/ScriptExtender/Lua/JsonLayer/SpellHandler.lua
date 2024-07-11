function JsonUtils.BuildSpellStringPayload(spells, target, modGuid, stringType)
  CLUtils.Info("Entering BuildSpellStringPayload")
  return {
    modGuid = modGuid,
    Target = target,
    SubSpells = spells,
    Type = stringType
  }
end

function JsonUtils.ParseAndSubmitSpellStrings(spells, target, modGuid, stringType, action)
  CLUtils.Info("Entering ParseAndSubmitSpellStrings")
  local payloads = {
    Insert = JsonUtils.BuildSpellStringPayload(spells, target, modGuid, stringType),
    Remove = JsonUtils.BuildSpellStringPayload(spells, target, modGuid, stringType)
  }

  if payloads[action] ~= nil then
    JsonUtils.Endpoints[action].SpellData({ payloads[action] })
  end
end

function SpellSubsectionHandler(data, modGuid)
  modGuid = data.modGuid or modGuid
  local blacklistedKeys = { ["modGuid"] = true, ["UUID"] = true, ["ID"] = true, ["Action"] = true, ["Comment"] = true }
  for key, val in pairs(data) do
    if not blacklistedKeys[key] then
      JsonUtils.ParseAndSubmitSpellStrings(val, data.ID, modGuid, key, data.Action)
    end
  end
end

function SpellJsonHandler(data, modGuid)
  CLUtils.Info("Entering SpellJsonHandler")
  for _, spell in pairs(data) do
    SpellSubsectionHandler(spell, modGuid)
  end
end
