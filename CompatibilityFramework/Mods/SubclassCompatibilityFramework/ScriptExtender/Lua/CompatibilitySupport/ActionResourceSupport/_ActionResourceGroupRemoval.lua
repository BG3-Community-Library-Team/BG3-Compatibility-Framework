local function RemoveActionResourceGroup(payload)
  local resourceGroupArr = CLUtils.CacheOrRetrieve(payload.TargetUUID, "ActionResourceGroup").ActionResourceDefinitions
  local result = {}
  if resourceGroupArr == nil then
    CLUtils.Error(CLStrings.ERROR_TARGET_NOT_FOUND)
  end
  if resourceGroupArr ~= nil then
    for _, uuid in resourceGroupArr do
      if not CLUtils.IsInTable(payload.Definitions, uuid) then
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
    CLUtils.Error(CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
