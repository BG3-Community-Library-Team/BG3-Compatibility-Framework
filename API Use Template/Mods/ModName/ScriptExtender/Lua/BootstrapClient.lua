if Ext.Mod.IsModLoaded("67fbbd53-7c7d-4cfa-9409-6d737b4d92a9") then
  local subClasses = {
    AuthorSubclass = {
      modGuid = "your-mods-uuid-in-metalsx",
      subClassGuid = "your-subclass-class-description-uuid",
      class = "lowercase parent class name or UUID for class progression granting subclass choices",
      subClassName = "English-localized name for your class (Optional)"
    }
  }

  local function OnStatsLoaded()
    Mods.SubclassCompatibilityFramework.Api.InsertSubClasses(subClasses)
  end

  Ext.Events.StatsLoaded:Subscribe(OnStatsLoaded)
end
