local function OnStatsLoaded()
  LoadConfigFiles()
end

Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)