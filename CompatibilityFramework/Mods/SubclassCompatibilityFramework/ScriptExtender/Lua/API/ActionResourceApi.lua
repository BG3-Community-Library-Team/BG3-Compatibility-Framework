function Api.InsertResourceToGroup(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      Utils.Info(Utils.Stringify(payload))
      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleActionResourceGroupAddition(payload)
      end
    end
  end
end

function Api.RemoveResourceFromGroup(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      Utils.Info(Utils.Stringify(payload))
      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleActionResourceGroupRemoval(payload)
      end
    end
  end
end
