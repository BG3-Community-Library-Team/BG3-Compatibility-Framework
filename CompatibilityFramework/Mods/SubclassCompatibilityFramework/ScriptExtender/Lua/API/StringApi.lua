-- Add support for Custom Strings
function Api.InsertStrings(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      CLUtils.Info(CLUtils.Stringify(payload))

      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleString(payload, "Strings")
      end
    end
  end
end

-- Add support for Custom Boosts
function Api.RemoveStrings(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      CLUtils.Info(CLUtils.Stringify(payload))

      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleString(payload, "Strings_Remove")
      end
    end
  end
end

function Api.InsertSpellStrings(payloads)
  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      { Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      CLUtils.Warn(err)
      return
    end

    HandleSpellString(payload)
  end
end

function Api.RemoveSpellStrings(payloads)
  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      { Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.ERROR_MOD_NOT_LOADED } })

    if err ~= nil then
      CLUtils.Warn(err)
      return
    end

    HandleRemoveSpellString(payload)
  end
end

function Api.InsertBoosts(payloads)
  Api.InsertStrings(payloads)
end

function Api.RemoveBoosts(payloads)
  Api.RemoveStrings(payloads)
end

function Api.InsertPassives(payloads)
  Api.InsertStrings(payloads)
end

function Api.RemovePassives(payloads)
  Api.RemoveStrings(payloads)
end

function Api.InsertPassivesForRemoval(payloads)
  Api.InsertStrings(payloads)
end

function Api.RemovePassivesForRemoval(payloads)
  Api.RemoveStrings(payloads)
end

function Api.InsertRequirements(payloads)
  Api.InsertStrings(payloads)
end

function Api.RemoveRequirements(payloads)
  Api.RemoveStrings(payloads)
end
