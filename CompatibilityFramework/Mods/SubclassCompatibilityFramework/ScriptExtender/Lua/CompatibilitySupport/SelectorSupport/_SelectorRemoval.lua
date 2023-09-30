local function RemoveSelector(payload)
  Utils.Info("Entering RemoveSelector")
  local target = payload.TargetUUID
  local type = payload.FileType or "Progression"
  local selectorField = Utils.CacheOrRetrieve(target, type)[payload.Function]
  local result = {}

  for _, selector in pairs(selectorField) do
    selectorUUID = selector.SpellUUID or selector.UUID
    if selectorUUID ~= nil and selectorUUID ~= payload.ListUUID then
      table.insert(result, selector)
    end
  end

  selectorField = result
end

function HandleSelectorRemoval(payload)
  Utils.Info("Entering HandleSelector")
  if payload ~= nil then
    if not Utils.IsInTable(Globals.CacheTypes, payload.FileType) then
      Utils.Error(Strings.ERROR_INVALID_TYPE)
    else
      RemoveSelector(payload)
    end
  else
    Utils.Error(Strings.ERROR_EMPTY_PAYLOAD)
  end
end
