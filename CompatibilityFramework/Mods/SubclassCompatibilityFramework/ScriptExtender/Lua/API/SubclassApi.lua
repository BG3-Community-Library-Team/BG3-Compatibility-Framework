-- For adding Support to 1 or more Subclasses
function Api.InsertSubClasses(payloads)
  for _, payload in pairs(payloads) do
    local err = DoValidation(payload,
      {
        Validators = { IsPayloadEmpty = Strings.ERROR_EMPTY_PAYLOAD, IsModLoaded = Strings.ERROR_MOD_NOT_LOADED },
        IsIntegrated = payload.isIntegrated
      })

    if err ~= nil then
      if not payload.isIntegrated then
        Utils.Warn(err)
      end

      return
    end
    if not Globals.AllowPayloads then
      Utils.AddToLateLoaders(payload.modGuid)
    end
    SubClassHandler(payload)
  end
end

-- For adding support to a Custom Class. TODO: Reduce Risk of Collisions
function Api.InsertClass(className, classGuid)
  Globals.ClassUUIDs[className] = classGuid
end

-- Additional endpoint to ensure support for classes with a level 1 subclass choice
function Api.InsertLevelOneProgression(className, classGuid)
  Globals.MulticlassClasses[className] = classGuid
end