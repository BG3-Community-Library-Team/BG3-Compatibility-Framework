local function OnSessionLoaded()
  if IntegratedSupport.SubClasses ~= nil then
    Api.InsertSubClasses(IntegratedSupport.SubClasses)
  end
end

Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded)
