#!/bin/sh

set -e

gh_repo="libreoffice-style-sifr"
gh_desc="Sifr LibreOffice icon themes"

cat <<- EOF

  $gh_desc
  https://github.com/rizmut/$gh_repo
  
  
EOF

temp_dir="$(mktemp -d)"

cd "images_sifr"
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
echo "=> Deleting old $gh_desc ..."
sudo rm -f "/usr/share/libreoffice/share/config/images_sifr.zip"
echo "=> Installing ..."
sudo mkdir -p "/usr/share/libreoffice/share/config"
sudo cp \
  "build/images_sifr.zip" \
  "/usr/share/libreoffice/share/config"
for dir in \
  /usr/lib64/libreoffice/share/config \
  /usr/lib/libreoffice/share/config \
  /usr/local/lib/libreoffice/share/config \
  /opt/libreoffice*/share/config; do
  [ -d "$dir" ] || continue
  sudo ln -sf "/usr/share/libreoffice/share/config/images_sifr.zip" "$dir"
done
echo "=> Done!"
