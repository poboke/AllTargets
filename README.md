
# AllTargets
  AllTargets is a plugin for Xcode. The plugin intends to auto select all targets when you add files to the project.
 ![image](https://github.com/poboke/AllTargets/raw/master/Images/about.png)

## Support Xcode Versions
  - Xcode5
  - Xcode6 GM

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
  MIT License

