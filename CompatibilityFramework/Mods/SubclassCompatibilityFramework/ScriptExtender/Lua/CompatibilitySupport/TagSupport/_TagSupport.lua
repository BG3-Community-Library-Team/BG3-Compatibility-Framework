-- local result = {
--   modGuid = data.modGuid or modGuid,
--   TargetUUID = target,
--   TagType = data.Type,
--   TagList = {"UUID","UUID"},
--   FileType = fileType
-- }
local TagFileTargets = {
  Origin = {
    Really = "ReallyTags",
    Appearance = "AppearanceTags"
  },
  ClassDescriptions = {
    Tags = "Tags"
  }
}

local function AddToTempTable(tempTable, arr)
  CLUtils.Info(Strings.PREFIX .. "Entering AddToTempTable")
  for _, item in pairs(arr) do
    if not CLUtils.IsInTable(tempTable, item) then
      table.insert(tempTable, item)
    end
  end
end
local function PrepareQueueTable(tempTable, tagType, fileType, target)
  if tempTable[fileType][tagType][target] == nil then
    tempTable[fileType][tagType][target] = {}
  end
end

local function QueueTags(payload, actionType)
  CLUtils.Info(Strings.PREFIX .. "Entering QueueTags")

  if actionType == 'Add' then
    PrepareQueueTable(Queue.Tags, payload.TagType, payload.FileType, payload.TargetUUID)
    AddToTempTable(Queue.Tags[payload.FileType][payload.TagType][payload.TargetUUID], payload.TagList)
  elseif actionType == 'Remove' then
    PrepareQueueTable(Queue.Tags_Remove, payload.TagType, payload.FileType, payload.TargetUUID)
    AddToTempTable(Queue.Tags_Remove[payload.FileType][payload.TagType][payload.TargetUUID], payload.TagList)
  end
end

function HandleTags(payload, actionType)
  if payload ~= nil then
    CLUtils.Info(Strings.PREFIX .. "Entering HandleTags")
    QueueTags(payload, actionType)
  else
    CLUtils.Error(Strings.PREFIX .. CLStrings.ERROR_EMPTY_PAYLOAD)
  end
end
