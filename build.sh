#!/bin/bash
#2020 by Rizal Muttaqin

if ! command -v optipng >/dev/null
then
    echo "Please install optipng"
    exit 1
fi

echo "=> Remove old PNG both light and dark version"
cp "images_sifr/links.txt" \
   "images_sifr_svg"
rm -Rf "images_sifr"
rm -Rf "images_sifr_dark"

cp -Rf "images_sifr_svg" \
   "images_sifr"
rm "images_sifr_svg/links.txt"
cd "images_sifr"

echo "=> 1. sifr PNG (light) version"
echo "=> Export light SVG to PNG ..."
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

echo "=> Delete light SVG files ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do
    fname=$( basename "$i")
    fdir=$( dirname "$i")
    rm "$i"
done

echo "=> 2. sifr SVG (dark) version"
cd "./.."

cp -Rf "images_sifr_svg" \
   "images_sifr_dark_svg"
cd "images_sifr_dark_svg"   

find -name "*.svg" -o -name "*.SVG" | while read i;
do 
	echo "This $i file will be Dark Theme"
	fname=$( basename "$i")
#	echo "has the name: $fname"
	fdir=$( dirname "$i")
#	echo "and is in the directory: ${fdir##*/}"
	#inkscape -f "$i" -e "${i%.*}.png"
	sed -i -e 's/#555753/#aaa8ac/g' "$i"
# for res/chart2
    sed -i -e 's/#232629/#aaa8ac/g' "$i"
	sed -i -e 's/#545853/#aba7ac/g' "$i" 
	sed -i -e 's/#bbbcb8/#444347/g' "$i"
	sed -i -e 's/#babbb7/#454448/g' "$i"
	sed -i -e 's/#232629/#dcd9d6/g' "$i"
	sed -i -e 's/#4a4f48/#b5b0b7/g' "$i"
	sed -i -e 's/#7a7e79/#858186/g' "$i"
	sed -i -e 's/#9d9f9a/#626065/g' "$i"
	sed -i -e 's/#d9d9d7/#262628/g' "$i"
	sed -i -e 's/#000000/#ffffff/g' "$i"
	sed -i -e 's/#ffffff/#000000/g' "$i"
	#convert "$i" -quality 75 "$i"
done 

echo "=> 3. sifr PNG (dark) version"
cd "./.."

cp -Rf "images_sifr_dark_svg" \
   "images_sifr_dark"
cp "images_sifr/links.txt images_sifr_dark"
cd "images_sifr_dark" 

echo "=> Export dark SVG to PNG ..."
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

echo "=> Delete dark SVG files ..."
find -name "*.svg" -o -name "*.SVG" | while read i;
do
    fname=$( basename "$i")
    fdir=$( dirname "$i")
    rm "$i"
done
