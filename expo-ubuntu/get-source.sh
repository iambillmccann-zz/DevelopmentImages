#!/bin/bash
set -e

gitRepo=$1
pat=$2
gitDir=$3

srcDir=/home/dev/src
#gitDir=${gitRepo##*/}
#gitDir=$gitRepo | rev | cut -d / -f1 | rev
echo "*********************************************"
echo " Starting get-source"
echo "---------------------------------------------"
echo " Git repository is $gitRepo"
echo " PAT is $pat"
echo " Git folder is $gitDir"
echo " Source folder is $srcDir"
echo "*********************************************"

cd $srcDir

if [ -d "${gitDir}" ] 
then
    echo "$gitRepo already cloned" 
    exit 0
fi

if [ "$pat" != "NOTSET" ]
then
    echo "cloninng git repo $gitRepo"
    git clone --branch master "https://$pat@$gitRepo"
    echo "git repo cloned successfully"
    cd $gitDir
else
    echo  "starting fresh"
    expo init $gitDir --non-interactive --template blank
    cd $gitDir
    npm install react-native-paper
    npm install --save react-native-vector-icons
    npm install expo-font@8.3.0 @expo-google-fonts/poppins
fi

echo "installing packages"
npm install
echo "Ready to start coding"