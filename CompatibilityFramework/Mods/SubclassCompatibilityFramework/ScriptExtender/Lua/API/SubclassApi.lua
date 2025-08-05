-- For adding Support to 1 or more Subclasses
function Api.InsertSubClasses(payloads)
  if not CLUtils.IsInTable(Globals.Deprecated.SubclassAPI, payloads.modGuid) then
    local modHandle = CLUtils.RetrieveModHandleAndAuthor(payloads.modGuid)
    if modHandle ~= CLStrings.WARN_GUID_NOT_DEFINED then
      table.insert(Globals.Deprecated.SubclassAPI, CLUtils.RetrieveModHandleAndAuthor(payloads.modGuid))
    end
  end
end

function Api.RemoveSubClasses(payloads)
  for _, payload in pairs(payloads) do
    local err = CLUtils.DoValidation(payload,
      {
        Validators = { IsPayloadEmpty = CLStrings.ERROR_EMPTY_PAYLOAD, IsModLoaded = CLStrings.VAL_ERR_MOD_NOT_LOADED },
        IsIntegrated = payload.isIntegrated
      })
    if err ~= nil then
      Globals.ValidationErrors[payload.modGuid] = CLUtils.RetrieveModHandleAndAuthor(payload.modGuid)
      return
    end
    if not Globals.AllowPayloads then
      Utils.AddToLateLoaders(payload.modGuid)
    end
    SubClassHandler(payload, "Remove")
  end
end

-- For adding support to a Custom Class. TODO: Reduce Risk of Collisions
function Api.InsertClass(className, classGuid)
  CLGlobals.ClassUUIDs[className] = classGuid
end

-- Additional endpoint to ensure support for classes with a level 1 subclass choice
function Api.InsertLevelOneProgression(className, classGuid)
  Globals.MulticlassClasses[className] = classGuid
end
