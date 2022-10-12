#!/bin/bash

find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file will updated to the black and white"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	#inkscape -f "$i" -e "${i%.*}.png"
	sed -i -e 's/#555753/#2e3436/g' "$i"
    sed -i -e 's/#fff/#fafafa/g' "$i"
    #convert "$i" -quality 75 "$i"
done
