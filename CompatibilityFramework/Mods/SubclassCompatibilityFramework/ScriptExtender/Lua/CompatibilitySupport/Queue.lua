function Queue.Commit()
  Queue.CommitLists()
  Queue.CommitProgressions()
end

function Queue.CommitLists()
  for type, listList in pairs(Queue.Lists) do
    for listId, list in pairs(listList) do
      local gameList = Utils.CacheOrRetrieve(listId, type)
      local strippedList = Utils.StripInvalidStatData(list)

      gameList[Globals.ListNodes[type]] = strippedList
    end
  end
end

function Queue.CommitProgressions_Subclasses(progression, subclasses)
  local strippedList = Utils.StripInvalidStaticData(subclasses, "ClassDescription")
  for _, vanillaEntry in pairs(progression.SubClasses) do
    Utils.AddToTable(strippedList, vanillaEntry)
  end

  progression.SubClasses = Utils.SortStaticData(strippedList, "ClassDescription", "DisplayName")
end

function Queue.CommitProgressions_Strings(progression, stringArr)

end

function Queue.CommitProgressions_Selectors(progression, selectors)

end

function Queue.CommitProgressions_Booleans(progression, selectors)

end

function Queue.CommitProgressions()
  for progressionId, progressionTable in pairs(Queue.Progressions) do
    local progression = Utils.CacheOrRetrieve(progressionId, "Progression")
    if progression ~= nil then
            if progressionTable.SubClasses ~= nil then
                Queue.CommitProgressions_Subclasses(progression, progressionTable.SubClasses)
            end
      
            if progressionTable.Selectors ~= nil then

            end
            
            if progressionTable.Strings ~= nil then

            end
            
            if progressionTable.Booleans ~= nil then
              
            end
    end
  end
end
