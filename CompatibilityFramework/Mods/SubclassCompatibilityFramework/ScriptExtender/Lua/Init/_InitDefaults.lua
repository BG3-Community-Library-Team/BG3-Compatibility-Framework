local function OnStatsLoaded()
  LoadConfigFiles()

  Queue.Commit()
end

Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)