local function OnStatsLoaded()
  LoadConfigFiles()

  Queue.Commit()
  Utils.Warn(Strings.WARN_LAST_CALL)
end

Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)
