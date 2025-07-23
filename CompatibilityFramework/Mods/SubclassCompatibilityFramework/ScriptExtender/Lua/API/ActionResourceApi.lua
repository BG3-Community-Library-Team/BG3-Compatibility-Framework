function Api.InsertResourceToGroup(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      CLUtils.Info(Strings.PREFIX .. CLUtils.Stringify(payload))
      if Ext.Mod.IsModLoaded(payload.modGuid) then
        if not Globals.AllowPayloads then
          Utils.AddToLateLoaders(payload.modGuid)
        end
        HandleActionResourceGroupAddition(payload)
      end
    end
  end
end

function Api.RemoveResourceFromGroup(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      CLUtils.Info(Strings.PREFIX .. CLUtils.Stringify(payload))
      if Ext.Mod.IsModLoaded(payload.modGuid) then
        if not Globals.AllowPayloads then
          Utils.AddToLateLoaders(payload.modGuid)
        end
        HandleActionResourceGroupRemoval(payload)
      end
    end
  end
end
