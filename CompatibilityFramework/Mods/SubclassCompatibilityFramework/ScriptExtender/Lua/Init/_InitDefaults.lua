local function OnStatsLoaded()
  LoadConfigFiles()

  Queue.Commit()
  Utils.Warn(Strings.WARN_LAST_CALL)
end

Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)

local function CloseRegistration()
  Utils.Info("Closing Registration")
  Globals.AllowPayloads = false
end

Ext.Events.SessionLoading:Subscribe(CloseRegistration, {
  Priority = 0
})
