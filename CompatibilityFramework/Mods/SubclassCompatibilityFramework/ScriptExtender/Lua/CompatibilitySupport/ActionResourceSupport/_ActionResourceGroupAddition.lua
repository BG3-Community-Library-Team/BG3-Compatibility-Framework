local function AddActionResourceGroup(payload)
  local resourceGroupArr = Utils.CacheOrRetrieve(payload.TargetUUID, "ActionResourceGroup").ActionResourceDefinitions
  if resourceGroupArr == nil then
    Utils.Error(Strings.ERROR_TARGET_NOT_FOUND)
  end
  resourceGroupArr = Utils.MergeTables(resourceGroupArr, payload.Definitions)
end

function HandleActionResourceGroupAddition(payload)
  if payload ~= nil then
    AddActionResourceGroup(payload)
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
