#!/bin/bash

find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file will updated to the black and white"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	#inkscape -f "$i" -e "${i%.*}.png"
	sed -i -e 's/#f62459/#555753/g' "$i"
    sed -i -e 's/#f73768/#545853/g' "$i"
    sed -i -e 's/#22a7f0/#bbbcb8/g' "$i"
    sed -i -e 's/#19b5fe/#babbb7/g' "$i"
    sed -i -e 's/#62c1f4/#9d9f9a/g' "$i"
    sed -i -e 's/#8bd1f7/#d9d9d7/g' "$i"
    sed -i -e 's/#f8567f/#4a4f48/g' "$i"
    sed -i -e 's/#fa86a4/#7a7e79/g' "$i"
    #convert "$i" -quality 75 "$i"
done
