BlacklistSupport = {}

function BlacklistSupport.ClassBlacklist(payload)
  local fleshedClass = CLUtils.CacheOrRetrieve(payload.ClassUUID, "ClassDescription")
  CLUtils.Info(Strings.PREFIX .. " Adding  " .. fleshedClass.Name .. " to blacklist on behalf of " .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid))
  if payload.Blacklist then
    CLUtils.Info(Strings.PREFIX .. Strings.BLACKLISTING_CLASS .. fleshedClass.Name, true)
    Globals.SubclassBlacklist[fleshedClass.Name] = Globals.SubclassBlacklist[fleshedClass.Name] or {}
    table.insert(Globals.SubclassBlacklist[fleshedClass.Name], payload.ClassUUID)
  else
    localItemKey = CLUtils.GetKeyFromvalue(Globals.SubclassBlacklist, payload.ClassUUID)
    if localItemKey and CLUtils.IsInTable(Globals.SubclassBlacklist, payload.ClassUUID) then
      CLUtils.Info(Strings.PREFIX .. "Removing " .. fleshedClass.Name .. " from blacklist on behalf of " .. CLUtils.RetrieveModHandleAndAuthor(payload.modGuid))
      table.remove(Globals.SubclassBlacklist, localItemKey)
    end
  end
end

function BlacklistHandler(payload, objType)
  if objType == "Class" then
    BlacklistSupport.ClassBlacklist(payload)
  end
end
