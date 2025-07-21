Strings = {}

Strings.LOADED_MAIN_CLASSES = "Main Classes Added."
Strings.GENERATING_LATE_LOADERS = "Building Late Loader String."
Strings.WARN_INVALID_SPELLDATA_SUPPLIED =
"The following Stats Data was either supplied to CF or manually defined in *List.lsx, but does not exist: "
Strings.WARN_SERVER_FUNCTION_NO_LONGER_REQUIRED =
" to Compatibility Framework API from BootstrapServer.lua. THIS IS NOT A BUG. The mod using Compatibility Framework API can remove their API call from BootstrapServer file, leaving it in the BootstrapClient file."
Strings.WARN_LAST_CALL =
"StatsLoaded Complete. Any mods calling the CF API after this point may not appear. Please contact the developer of any missing mods and inform them to switch their CF API call to happen on StatsLoaded instead of on SessionLoaded."
Strings.LATE_LOADER_PREFIX =
"The following mods are attempting to call Compatibility Framework API too late for it to take effect: "
Strings.ERR_CL_NOT_LOADED = "Community Library is required for Compatibility Framework to function."
Strings.ERR_JSON_PARSE_FAIL = "Couldn't Parse CF JSON Configuration File from "
Strings.CHANGES_NOT_APPLIED = "Changes will not be applied."
Strings.ERR_DID_NOT_PROVIDE_STRINGS = " did not provide a valid Strings table in CF config for target List: "
Strings.ERR_DID_NOT_PROVIDE_LIST = " did not provide a valid List Items table for list type "
Strings.ERR_DID_NOT_PROVIDE_BOOLEANS = " did not provide a valid Boolean values in CF config for target "
Strings.ERR_DID_NOT_PROVIDE_LIST_TYPE = " did not provide a valid List Type in CF config."
Strings.ERR_DID_NOT_PROVIDE_AR_DEFINITIONS = " did not provide a valid Action Resource Definitions table in CF config for target Action Resource Group UUID: "
Strings.ERR_DID_NOT_PROVIDE_SELECTOR_FUNCTION = " did not provide a valid Selector Function value in CF config for target UUID:"
Strings.ERR_DID_NOT_PROVIDE_PARAMS = " did not provide a valid Params table in CF config for target Selector:  "
