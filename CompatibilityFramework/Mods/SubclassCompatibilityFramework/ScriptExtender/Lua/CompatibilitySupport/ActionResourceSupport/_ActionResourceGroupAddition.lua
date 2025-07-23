local function AddActionResourceGroup(payload)
  local resourceGroupArr = CLUtils.CacheOrRetrieve(payload.TargetUUID, "ActionResourceGroup").ActionResourceDefinitions
  if resourceGroupArr == nil then
    CLUtils.Error(Strings.PREFIX .. Strings.ERROR_TARGET_NOT_FOUND)
  end
  resourceGroupArr = CLUtils.MergeTables(resourceGroupArr, payload.Definitions)
end

function HandleActionResourceGroupAddition(payload)
  if payload ~= nil then
    AddActionResourceGroup(payload)
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
