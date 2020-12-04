#!/bin/bash
echo "starting docker"
set -e

gitRepo=""
pat="NOTSET"
folder="NOTSET"
#read command line options
#e.g. option passing --gitRepo my.visualstudio.com/_git/myrepo --pat sc5c6vooqlbkwliriaofrz66cu5tlfasa7mbiqwrj
while [ -n "$1" ]; do
  case "$1" in			
    -g|--gitRepo)
      gitRepo="$2"
      shift 2
      ;;
    -p|--pat)
      pat="$2"
      shift 2
      ;;
    -f|--folder)
      folder="$2"
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *)
      echo 'invalid options'
      exit 3
      ;;
  esac    
done

/get-source.sh $gitRepo $pat $folder

while true; do sleep 1000; done
echo "exiting docker"