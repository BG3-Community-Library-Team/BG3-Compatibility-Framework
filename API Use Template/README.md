Drop this into your Mod Folder and make the following changes:

1. Update Config.json's ModTable value to your Mod's Name.
2. Go into BoostrapServer.lua and change the following:

AuthorSubclass: Replace this with your username and the name of the subclass. Example: FeriatHexblade. These can be shortened.

modGuid: Change the value to your Mod's UUID as defined in meta.lsx.

subClassGuid: Change the value to your Subclasses UUID as defined in ClassDescriptions.lsx.

class: Change this to the lower-case name of your classes Parent class. This will typically be one of the following: barbarian, bard, cleric, druid, fighter, monk, paladin, ranger, rogue, sorcerer, warlock, wizard.

subClassName : This field is optional. It will be used for a future sorting feature. Change the value to the English-localized name for your subclass.