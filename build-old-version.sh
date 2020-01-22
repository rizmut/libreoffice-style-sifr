#!/bin/bash
# 2019 by Rizal Muttaqin

echo "=> Remove old PNG both light and dark version"
cp "images_sifr/links.txt" \
   "images_sifr_svg"
rm -Rf "images_sifr"
rm -Rf "images_sifr_dark"

cp -Rf "images_sifr_svg" \
   "images_sifr"
rm "images_sifr_svg/links.txt"
cd "images_sifr"   

echo "=> Export light SVG to light PNG ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file is compressed"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	inkscape -f "$i" -e "${i%.*}.png"
	optipng -o7 "${i%.*}.png"
	#convert "$i" -quality 75 "$i"
done

echo "=> Delete duplicate SVG files ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do
    fname=$( basename "$i")
    fdir=$( dirname "$i")
    rm "$i"
done

echo "=> Convert light PNG to dark PNG ..."

cd "./.."
cp -Rf "images_sifr" \
   "images_sifr_dark"
cd "images_sifr_dark"

rm "links.txt"
find -name "*.png" -o -name "*.PNG" | while read i;
do 
	echo "This $i file will be Dark Theme"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	#inkscape -f "$i" -e "${i%.*}.png"
	convert "$i" -negate "$i"
	#convert "$i" -quality 75 "$i"
done
