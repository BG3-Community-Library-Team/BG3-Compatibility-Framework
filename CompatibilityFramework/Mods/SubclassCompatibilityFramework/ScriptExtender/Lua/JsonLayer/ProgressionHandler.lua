local function ParseAndSubmitEntries(data, modGUid)

end

function ProgressionJsonHandler(data, modGuid)
    Utils.Info("Entering ProgressionJsonHandler")
    for _, progressions in pairs(data) do
        ParseAndSubmitEntries(progressions, modGuid)
    end
end