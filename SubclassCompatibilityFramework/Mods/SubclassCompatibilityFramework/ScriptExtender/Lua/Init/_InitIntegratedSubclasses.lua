local function OnSessionLoaded()
  -- Utils.Info(Utils.Stringify(IntegratedSupport.SubClasses))
  if IntegratedSupport.SubClasses ~= nil then
    Api.InsertSubClasses(IntegratedSupport.SubClasses)
  end
end

Ext.Events.SessionLoaded:Subscribe(OnSessionLoaded)