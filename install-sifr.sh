#!/bin/sh

set -e

gh_repo="libreoffice-style-karasa-jaga"
gh_desc="Karasa Jaga LibreOffice icon themes"

cat <<- EOF

  $gh_desc
  https://github.com/rizmut/$gh_repo
  
  
EOF

temp_dir="$(mktemp -d)"

echo "=> Getting the latest version from GitHub ..."
curl -L "https://github.com/rizmut/$gh_repo/archive/master.tar.gz" -o "/tmp/$gh_repo.tar.gz"
echo "=> Unpacking archive ..."
tar -xzf "/tmp/$gh_repo.tar.gz" -C "$temp_dir"
echo "=> Deleting old $gh_desc ..."
sudo rm -f "/usr/share/libreoffice/share/config/images_sifr.zip"
sudo rm -f "/usr/share/libreoffice/share/config/images_sifr_dark.zip"
sudo rm -f "/usr/share/libreoffice/share/config/images_sifr_dark_svg.zip"
sudo rm -f "/usr/share/libreoffice/share/config/images_sifr_svg.zip"
echo "=> Installing ..."
sudo mkdir -p "/usr/share/libreoffice/share/config"
sudo cp -R \
  "$temp_dir/$gh_repo-master/build/images_sifr.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp -R \
  "$temp_dir/$gh_repo-master/build/images_sifr_dark.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp -R \
  "$temp_dir/$gh_repo-master/build/images_sifr_dark_svg.zip" \
  "/usr/share/libreoffice/share/config"
sudo cp -R \
  "$temp_dir/$gh_repo-master/build/images_sifr_svg.zip" \
  "/usr/share/libreoffice/share/config"
for dir in \
  /usr/lib64/libreoffice/share/config \
  /usr/lib/libreoffice/share/config \
  /usr/local/lib/libreoffice/share/config \
  /opt/libreoffice*/share/config; do
  [ -d "$dir" ] || continue
  sudo ln -sf "/usr/share/libreoffice/share/config/images_sifr.zip" "$dir"
  sudo ln -sf "/usr/share/libreoffice/share/config/images_sifr_dark.zip" "$dir"
  sudo ln -sf "/usr/share/libreoffice/share/config/images_sifr_svg.zip" "$dir"
  sudo ln -sf "/usr/share/libreoffice/share/config/images_sifr_dark_svg.zip" "$dir"
done
echo "=> Clearing cache ..."
rm -rf "/tmp/$gh_repo.tar.gz" "$temp_dir"
echo "=> Done!"
