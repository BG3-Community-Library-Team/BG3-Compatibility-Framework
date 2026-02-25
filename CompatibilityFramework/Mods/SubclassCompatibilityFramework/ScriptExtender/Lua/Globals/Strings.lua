Strings = {}
Strings.PREFIX = "[CF] "
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
Strings.ERR_DID_NOT_PROVIDE_TAGS = " did not provide valid Tag UUID in CF config for target "
Strings.ERR_DID_NOT_PROVIDE_FIELD_KEY = " did not provide a valid Field Key in CF config for target "
Strings.ERR_DID_NOT_PROVIDE_FIELD_VALUE = " did not provide a valid Field Value in CF config for target "
Strings.ERR_DID_NOT_PROVIDE_LIST_TYPE = " did not provide a valid List Type in CF config."
Strings.ERR_DID_NOT_PROVIDE_AR_DEFINITIONS = " did not provide a valid Action Resource Definitions table in CF config for target Action Resource Group UUID: "
Strings.ERR_DID_NOT_PROVIDE_SELECTOR_FUNCTION = " did not provide a valid Selector Function value in CF config for target UUID:"
Strings.ERR_DID_NOT_PROVIDE_PARAMS = " did not provide a valid Params table in CF config for target Selector:  "
Strings.VAL_ERR_MOD_NOT_LOADED = "CF Detected Configurations for "
Strings.VAL_ERR_MOD_NOT_LOADED_B = " mods that aren't loaded: "
Strings.VAL_ERR_USER_REASSURANCE = "Mod Users: ignore this warning. This is for authors only."
Strings.VAL_ERR_UUID_IS_TABLE = " provided a table for UUID for progression IDs: "
Strings.VAL_ERR_UUID_IS_TABLE_B = ". Please use 'UUIDs' instead."
Strings.VAL_ERR_CLASS_DESCRIPTION_INVALID_PARENT = "'s Parent Class Description UUID is invalid. Please inform the author to confirm the ParentGuid value in ClassDescriptions."
Strings.DEP_SUBCLASS_API = "Deprecated Subclass API call(s) made. Compatibility Framework no longer requires API calls for adding Subclasses to a class - CF now handles this automatically. Please inform the authors of the following mods: "
Strings.DEP_SUBCLASS_JSON = "Deprecated Subclass Configuration(s) detected. Compatibility Framework no longer requires JSON configuration for adding Subclasses to a class - CF now handles this automatically. Please inform the authors of the following mods: "
Strings.DEP_ERR_USER_REASSURANCE = "Mod Users: Do not worry, this will not affect the stability of your game."
Strings.UNKNOWNGUID = "unknown - guid not defined"
Strings.BLACKLISTING_CLASS = "Blacklisting Class: "

-- YAML Parser
Strings.ERR_YAML_PARSE_FAIL       = "Couldn't parse CF YAML Configuration File from "
Strings.ERR_YAML_TAB_INDENT       = "Tabs are not allowed for YAML indentation, use spaces"
Strings.ERR_YAML_UNTERMINATED_STR  = "Unterminated quoted string in YAML config"
Strings.ERR_YAML_BAD_INDENT       = "Inconsistent indentation in YAML config"
Strings.ERR_YAML_EXPECTED_MAP_KEY = "Expected mapping key in YAML config"
Strings.ERR_YAML_UNDEFINED_ALIAS  = "Undefined YAML alias: "
Strings.WARN_YAML_ANCHOR_REDEF    = "YAML anchor redefined: "

-- List Inheritance & Exclusion
Strings.ERR_DID_NOT_PROVIDE_LIST_CONTENT =
  " did not provide Items, Inherit, or Exclude for list type "
Strings.WARN_SOURCE_LIST_NOT_FOUND = "Inherit/Exclude source list not found: "
Strings.WARN_INHERIT_WRONG_ACTION = " provided InheritFrom on a Remove action for list "
Strings.WARN_EXCLUDE_WRONG_ACTION = " provided ExcludeFrom on an Add action for list "
Strings.WARN_CIRCULAR_INHERIT = "Circular list inheritance detected for list: "

-- Generic (format-agnostic loader)
Strings.ERR_CONFIG_PARSE_FAIL     = "Couldn't parse CF Configuration File from "
