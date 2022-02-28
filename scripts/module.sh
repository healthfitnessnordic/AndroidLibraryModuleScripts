#!/bin/sh
# This is a script for making library modules in modular based project
# We have supported 4 types of library modules.
# regular - Regular library module without support for compose. This is where you would add some UI code and stuff
# data - Data module is a library module for handling data stuff
# compose - Regular library module with support for compose. Here you would also handle UI stuff
# test - Library module for fakes and testing
echo "Are you in the applications app folder?(Y, N)"
read folder

if [ "$folder" = "N" ]; then
 echo "Navigate to the app module where you want to make the library module"
 exit	
fi

echo "Enter package name"
read package

PACKAGE_FOLDER=$(echo $package | tr . /)

echo "Package folders: $PACKAGE_FOLDER"

echo "Making a library module with name: $1 and package name: $package"
mkdir $1/src/main/java/$PACKAGE_FOLDER -p
mkdir $1/src/main/res

echo "Do you want a test folder for unit tests? (Y, N)"
read test
if [ "$test" != "N" ]; then
 mkdir $1/src/test/$PACKAGE_FOLDER -p
fi

echo "Do you want a androidTest folder for android tests? (Y, N)"
read atest
if [ "$atest" != "N" ]; then
 mkdir $1/src/androidTest/$PACKAGE_FOLDER -p
fi

echo "Which module type would you like to make? Supported types are regular, compose, data and test (regular, compose, data, test)"
read type

if [ "$type" = "regular" ]; then
 ./regular-library-module.sh $1 $package
elif [ "$type" = "compose" ]; then
 ./compose-library-module.sh $1 $package
elif [ "$type" = "data" ]; then
 ./data-library-module.sh $1 $package
elif [ "$type" = "test" ]; then
 ./test-library-module.sh $1 $package
fi

