CF = {}
CF.UUID = "67fbbd53-7c7d-4cfa-9409-6d737b4d92a9"
CF.modTableKey = "SubclassCompatibilityFramework"
CF.modPrefix = "CF"
CF.modVersion = Ext.Mod.GetMod(CF.UUID).Info.ModVersion
Mods.CompatibilityFramework = Mods.SubclassCompatibilityFramework

local clImports = {}
clImports[1] = "Globals"
clImports[2] = "Strings"
clImports[3] = "DictUtils"
clImports[4] = "Utils"
clImports[5] = "Validators"

CLGlobals, CLStrings, CLDictUtils, CLUtils, CLValidators = Mods.CommunityLibrary.Import(clImports)
