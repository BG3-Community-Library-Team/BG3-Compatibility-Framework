# Subclass Compatibility Framework
[![GitHub release](https://img.shields.io/github/v/tag/BG3-Community-Library-Team/BG3-Subclass-Compatibility-Framework?label=Latest%20Version)](https://GitHub.com/BG3-Community-Library-Team/BG3-Subclass-Compatibility-Framework/releases/) [![GitHub commits](https://img.shields.io/github/commits-since/BG3-Community-Library-Team/BG3-Subclass-Compatibility-Framework/1.0.0.0/main)](https://GitHub.com/BG3-Community-Library-Team/BG3-Subclass-Compatibility-Framework/commit/)

This is the Subclass Compatibility Framework. Split off from BG3 Community Library, this mod aims to patch subclass mods created by the community, using a Community Submission approach. All compatibility patches set up in the Community Library have been moved to this library, and future requests to add Subclass Support are meant to come through here. If you want to know which subclasses are currently supported, [check out this list](https://github.com/BG3-Community-Library-Team/BG3-Subclass-Compatibility-Framework/wiki/Supported-Mods).

## Contributing
If you'd like to contribute to the Subclass Compatibility Framework, make a Fork of this project: [![GitHub forks](https://img.shields.io/github/forks/BG3-Community-Library-Team/BG3-Subclass-Compatibility-Framework)](https://GitHub.com/BG3-Community-Library-Team/BG3-Subclass-Compatibility-Framework/network/)

The Sucblass Compatibility Framework makes it easy to set your Subclass up for compatibility with other Subclass mods. You only need to add a small amount of code to three file. To find out how, [check out our Wiki page](https://github.com/BG3-Community-Library-Team/BG3-Subclass-Compatibility-Framework/wiki/Adding-a-Subclass-to-the-Subclass-Compatibility-Framework).


## Installation
This mod works with [Baldur's Gate 3 Mod Manager](https://github.com/LaughingLeader/BG3ModManager), and possibly Vortex and Manual
Installations. BG3 Mod Managers is by far the simplest method, and as such is recommended one.

[![Compatible with Laughing Leader's Baldur's Gate 3 Mod Manager](https://i.imgur.com/qtdx2Yq.png)](https://github.com/LaughingLeader/BG3ModManager)

#### Load Order
Your Load Order will look something like this:
```
- ImprovedUI (Optional, Recommended)
- SubclassCompatibilityFrameworkDummies
- Subclass Mods you wish to test with
- Your Subclass Mod (Except when testing without to ensure the game doesn't crash)
- SubclassCompatibilityFramework
- Other Mods
```

### BG3 Mod Manager
1. Download the latest release, and unzip the .pak file.
2. Open BG3 Mod Manager, click File->Import Mod.
3. Select SubclassCompatibilityFramework.pak.
4. Do the same for SubclassCompatibilityFrameworkDummies.pak.
5. Once both are imported hit refresh.
6. Drag SubclassCompatibilityFrameworkDummies to the top of the Left pane.
7. Drag SubclassCompatibilityFramework below SubclassCompatibilityFrameworkDummies, and below any supported subclass mods you have installed.
8. Hit "Save Load Order to File."

## Recommended Mod Management Tools
- [Laughing Leader's Mod Manager](https://github.com/LaughingLeader/BG3ModManager)

## Other Recommended Mods/Pages
- [Larian Studios Discord](https://discord.com/invite/larianstudios)

## Acknowledgements
- Larian Software, for working on Baldur's Gate 3 and bringing 5th Edition to PC.
- The Baldur's Gate 3 Modding Community.
- [https://github.com/ShinyHobo](ShinyHobo) for their work easing the process of creating .pak files.
- Alana for the creation of the Mod Manager Compatibility Images.
