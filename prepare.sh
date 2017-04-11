#!/usr/bin/env bash

## This file is licensed MIT, and is based on the prepare.sh script
# from the Fondue6 project (https://github.com/elytra/Fondue6)

find ./src/ -name '*.jar' | while read file; do
	if [ ! -e "${file}.url.txt" ]; then
		echo Deleting dangling file `basename $file`...
		rm $file
	fi
done

find ./ -name '*.url.txt' | while read file; do
	basename=${file%.url.txt}
	if [ ! -e "$basename" ]; then
		url=`cat $file`
		echo Downloading $url...
		curl -L -s "$url" -o "$basename"
	else
		echo Skipping download of existing file `basename $basename`
	fi
done
