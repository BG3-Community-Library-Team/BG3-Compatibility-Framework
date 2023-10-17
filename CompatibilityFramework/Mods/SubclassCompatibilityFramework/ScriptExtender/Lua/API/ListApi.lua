-- Handles SpellLists, SkillLists, and PassiveLists
function Api.InsertToList(payloads)
  if payloads ~= nil then
    for _, payload in pairs(payloads) do
      Utils.Info(Utils.Stringify(payload))
      if Ext.Mod.IsModLoaded(payload.modGuid) then
        HandleList(payload)
      end
    end
  end
end
