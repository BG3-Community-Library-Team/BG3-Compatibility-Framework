local function OnStatsLoaded()
  LoadConfigFiles()

  Queue.Commit()
  CLUtils.Warn(Strings.WARN_LAST_CALL)
end

Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded, { Priority = 9999 })

local function CloseRegistration()
  CLUtils.Info("Closing Registration")
  Globals.AllowPayloads = false
end

Ext.Events.SessionLoading:Subscribe(CloseRegistration, { Priority = 9999 })
