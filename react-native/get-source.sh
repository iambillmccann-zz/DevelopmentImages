#!/bin/sh
set -e

gitRepo=$1
pat=$2
gitDir=$3

srcDir=/home/dev/src
#gitDir=${gitRepo##*/}
#gitDir=$gitRepo | rev | cut -d / -f1 | rev

echo "Source folder is $srcDir"
echo "Git folder is $gitDir"

cd $srcDir

if [ -d "${gitDir}" ] 
then
    echo "$gitRepo already cloned" 
    exit 0
fi

if [ "$pat" != "NOTSET" ]
then
    echo "cloninng git repo $gitRepo"
#   git clone "https://$pat@$gitRepo"
    expo init beagle
    echo "git repo cloned successfully"
fi