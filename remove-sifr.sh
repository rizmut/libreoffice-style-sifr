#!/bin/sh

set -e

gh_repo="libreoffice-style-sifr"
gh_desc="Sifr LibreOffice icon themes"

cat <<- EOF

  $gh_desc
  https://github.com/rizmut/$gh_repo
  
  
EOF

echo "=> Removing $gh_desc ..."
for dir in \
  /usr/share/libreoffice/share/config \
  /usr/lib/libreoffice/share/config \
  /usr/lib64/libreoffice/share/config \
  /usr/local/lib/libreoffice/share/config \
  /opt/libreoffice*/share/config; do
  [ -d "$dir" ] || continue
  sudo rm -f "$dir/images_sifr.zip"
  sudo rm -f "$dir/images_sifr_svg.zip"
  sudo rm -f "$dir/images_sifr_dark.zip"
  sudo rm -f "$dir/images_sifr_dark_svg.zip"
done
echo "=> Done!"
