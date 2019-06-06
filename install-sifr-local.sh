#!/bin/sh

set -e

gh_repo="libreoffice-style-sifr"
gh_desc="Sifr LibreOffice icon themes"

cat <<- EOF

  $gh_desc
  https://github.com/rizmut/$gh_repo
  
  
EOF

temp_dir="$(mktemp -d)"

# Sifr
cd "images_sifr"
cp "links.txt" \
   "../images_sifr_dark"
zip -r -D images_sifr.zip *
mv "images_sifr.zip" \
  "./../build/"
cd "./../build/"
echo "=> Deleting old $gh_desc extension file ..."
rm -f "Sifr-IconSet.oxt"
echo "=> Create new $gh_desc extension one ..."
cp "images_sifr.zip" \
   "Sifr-IconSet/iconsets"
cd "./Sifr-IconSet"
zip -r -D Sifr-IconSet.oxt *
mv "Sifr-IconSet.oxt" \
   "./.."
cd "./../.."
# Sifr Dark
echo "=> Deleting old $gh_desc extension file (dark) ..."
cd "images_sifr_dark"
zip -r -D images_sifr_dark.zip *
mv "images_sifr_dark.zip" \
  "./../build/"
cd "./../build/"
echo "=> Deleting old $gh_desc extension file (dark) ..."
rm -f "Sifr-Dark-IconSet.oxt"
echo "=> Create new $gh_desc extension one (dark) ..."
cp "images_sifr_dark.zip" \
   "Sifr-Dark-IconSet/iconsets"
cd "./Sifr-Dark-IconSet"
zip -r -D Sifr-Dark-IconSet.oxt *
mv "Sifr-Dark-IconSet.oxt" \
   "./.."
cd "./../.."
#Sifr SVG
echo "=> Deleting old $gh_desc extension file (SVG) ..."
cd "images_sifr_svg"
zip -r -D images_sifr_svg.zip *
mv "images_sifr_svg.zip" \
  "./../build/"
cd "./../build/"
echo "=> Deleting old $gh_desc extension file (SVG) ..."
rm -f "Sifr-SVG-IconSet.oxt"
echo "=> Create new $gh_desc extension one (SVG) ..."
cp "images_sifr_svg.zip" \
   "Sifr-SVG-IconSet/iconsets"
cd "./Sifr-SVG-IconSet"
zip -r -D Sifr-SVG-IconSet.oxt *
mv "Sifr-SVG-IconSet.oxt" \
   "./.."
cd "./../.."
echo "=> Deleting whole old $gh_desc ..."
sudo rm -f "/usr/share/libreoffice/share/config/images_sifr.zip"
sudo rm -f "/usr/share/libreoffice/share/config/images_sifr_dark.zip"
sudo rm -f "/usr/share/libreoffice/share/config/images_sifr_svg.zip"
echo "=> Installing ..."
sudo mkdir -p "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_sifr.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_sifr_dark.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_sifr.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_sifr_svg.zip" \
  "/usr/share/libreoffice/share/config"
rm "images_sifr_dark/links.txt"
for dir in \
  /usr/lib64/libreoffice/share/config \
  /usr/lib/libreoffice/share/config \
  /usr/local/lib/libreoffice/share/config \
  /opt/libreoffice*/share/config; do
  [ -d "$dir" ] || continue
  sudo ln -sf "/usr/share/libreoffice/share/config/images_sifr.zip" "$dir"
  sudo ln -sf "/usr/share/libreoffice/share/config/images_sifr_dark.zip" "$dir"
  sudo ln -sf "/usr/share/libreoffice/share/config/images_sifr_svg.zip" "$dir"
done
echo "=> Done!"
