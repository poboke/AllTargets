
# AllTargets
  AllTargets is a plugin for Xcode. The plugin intends to auto select targets depending of the selected configuration when you add files to the project.
  
  ![image](https://github.com/fjtrujy/AllTargets/raw/master/Screenshots/mainMenu.png)
  ![image](https://github.com/poboke/AllTargets/raw/master/Screenshots/about.png)

  If sometimes you want to add files to a specif target, you can click the Xcode menu "Plugins", then to "Auto Select Targets" sub menu and then select/deselect all options.

## Support Xcode Versions
  - Xcode5
  - Xcode6
  - Xcode7

## Install
  - Using [Alcatraz](https://github.com/mneorr/Alcatraz)

## Manual build and install
  - Download source code and open AllTargets.xcodeproj with Xcode.
  - Select "Edit Scheme" and set "Build Configuration" as "Release"
  - Build it. It automatically installs the plugin into the correct directory.
  - Restart Xcode. (Make sure that the Xcode process is terminated entirely)

## Manual uninstall 
  Delete the following directory:

  $HOME/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/AllTargets.xcplugin

## Tutorial
  See the tutorial in my blog.

  http://www.poboke.com/study/write-a-xcode-plugin-to-auto-select-all-targets.html

## License
	(The WTFPL)
	
	            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
	                    Version 3, August 2016
	
	 Copyright (C) 2016 Jobs (www.poboke.com) & Fjtrujy (https://github.com/fjtrujy)
	
	 Everyone is permitted to copy and distribute verbatim or modified
	 copies of this license document, and changing it is allowed as long
	 as the name is changed.
	
	            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
	   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
	
	  0. You just DO WHAT THE FUCK YOU WANT TO.

