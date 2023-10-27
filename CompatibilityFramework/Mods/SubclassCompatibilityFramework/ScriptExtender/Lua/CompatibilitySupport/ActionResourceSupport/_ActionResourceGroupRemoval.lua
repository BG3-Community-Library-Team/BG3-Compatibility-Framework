local function RemoveActionResourceGroup(payload)
  local resourceGroupArr = Utils.CacheOrRetrieve(payload.TargetUUID, "ActionResourceGroup").ActionResourceDefinitions
  local result = {}
  if resourceGroupArr == nil then
    Utils.Error(Strings.ERROR_TARGET_NOT_FOUND)
  end
  if resourceGroupArr ~= nil then
    for _, uuid in resourceGroupArr do
      if not Utils.IsInTable(payload.Definitions, uuid) then
        table.insert(result, uuid)
      end
    end
  end

  resourceGroupArr = result
end

function HandleActionResourceGroupRemoval(payload)
  if payload ~= nil then
    RemoveActionResourceGroup(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
