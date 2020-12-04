#!/bin/sh
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
    git clone "https://$pat@$gitRepo"
    echo "git repo cloned successfully"
else
    echo  "starting fresh"
    expo init $gitDir --non-interactive --template blank
fi

cd $gitDir
echo "installing packages"
npm install
