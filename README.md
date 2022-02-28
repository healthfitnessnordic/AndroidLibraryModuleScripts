# AndroidLibraryModuleScripts
Some scripts to use for making library modules in a Android project. The modules will support Hilt.

You can test it out by cloning the project and run `./module.sh $nameOfModule`

By default the modules requires you to use version catalog, but feel free to change up the scrips to cater for your projects way of using dependencies.

In the scrips we have differentiated between 4 different library types

- Regular: This is the regular UI library module where you would put your UI code
- Compose: This is the regular UI library module where you would put your UI code. This also supports Jetpack Compose
- Data: This is the regular data module where you would put your data related code.
- Test: This is the a module where you can add fakes and test related stuff that you don't want in you production code.
