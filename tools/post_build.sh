#!/bin/bash
set -euo pipefail

MAJOR_VERSION=0
MINOR_VERSION=3
PATCH_VERSION=0
VERSION="v$MAJOR_VERSION.$MINOR_VERSION.$PATCH_VERSION"
VERSION_STR="v${MAJOR_VERSION}_${MINOR_VERSION}_${PATCH_VERSION}"

# Add Inline Ads to specific locations in HTML files
# Looks for {IN_ARTICLE_AD} placeholder and replaces it with the ad code
esc_pipes() { printf '%s' "$1" | sed 's/|/\\|/g'; }
SRC_STR="<p>{IN_ARTICLE_AD}</p>"
DEST_STR='<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-7754158240191404" crossorigin="anonymous"></script><ins class="adsbygoogle" style="display:block; text-align:center;" data-ad-layout="in-article" data-ad-format="fluid" data-ad-client="ca-pub-7754158240191404" data-ad-slot="7243000500"></ins><script>(adsbygoogle = window.adsbygoogle || []).push({});</script>'
DEST_STR=$(esc_pipes "$DEST_STR")
find ./book -type f -name '*.html' -print0 | xargs -0 -I% sed -i 's|'"$SRC_STR"'|'"$DEST_STR"'|g' %
echo "Ads added to all HTML files in the book directory."

# Support Google Adsense Auto Placement
# NOTE: we are disabling auto placement for now, as it is not acheiving the desired results
# find ./book -name '*.html' -exec sed -i 's|<head>|<head><script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-7754158240191404" crossorigin="anonymous"></script>|' {} +

# Support Google Analytics
SRC_STR="<head>"
DEST_STR='<head><script async src="https://www.googletagmanager.com/gtag/js?id=G-BH2MZC1S69"></script><script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','G-BH2MZC1S69');</script>'
DEST_STR=$(esc_pipes "$DEST_STR")
find ./book -type f -name '*.html' -print0 | xargs -0 -I% sed -i 's|'"$SRC_STR"'|'"$DEST_STR"'|g' %
echo "Google Analytics added to all HTML files in the book directory."

createDownloadHtml() {
  local html_file_name="$1"
  local file_path="$2"
  cp "./tools/download.html" "./book/$html_file_name"
  sed -i "s|const DOWNLOAD_URL = './null'|const DOWNLOAD_URL = '$file_path'|g" "./book/$html_file_name"
  echo "Created download HTML: ./book/$html_file_name with DOWNLOAD_URL set to $file_path"
}

replace_download_links() {
  local file_path
  local button_text
  case "$1" in
    "WINDOWS_X86_64_EXE") file_path="./wbu_x86_64_windows_$VERSION_STR.exe" ;;
    "LINUX_X86_64")      file_path="./wbu_x86_64_linux_$VERSION_STR" ;;
    "MAC_INTEL_X86_64")  file_path="./wbu_x86_64_mac_intel_$VERSION_STR" ;;
    "MAC_APPLE_SILICON_X86_64")  file_path="./wbu_aarch64_mac_apple_silicon_$VERSION_STR" ;;
    *) echo "Invalid key to replace." && exit 1 ;;
  esac

  [ -f "./src/$file_path" ] || { echo "Error: '$file_path' not found"; exit 1; }

  html_file="${1}_download.html"
  createDownloadHtml "$html_file" "$file_path"

  case "$1" in
    "WINDOWS_X86_64_EXE") button_text="Western Blot Utility for Windows" ;;
    "LINUX_X86_64")      button_text="Western Blot Utility for Linux" ;;
    "MAC_INTEL_X86_64")  button_text="Western Blot Utility for Mac with Intel Chip" ;;
    "MAC_APPLE_SILICON_X86_64")  button_text="Western Blot Utility for Mac with Apple Silicon" ;;
  esac

  # Handle download button replacement
  local SRC="{$1}"
  local DST='<a \
      id="download-'"$1"'-btn" \
      style="color: #fff; text-decoration: none;" \
      class="download-btn" \
      href="./'"$html_file"'" \
      title="Download executable for '"$VERSION"'">'"$button_text"'</a>'

  sed -i 's|'"$SRC"'|'"$DST"'|g' "./book/installation.html"
  echo "Inserted download button for $1 in installation.html"
}

replace_download_links "WINDOWS_X86_64_EXE"
replace_download_links "LINUX_X86_64"
replace_download_links "MAC_INTEL_X86_64"
replace_download_links "MAC_APPLE_SILICON_X86_64"
echo "Post-build script completed."

# Append download-button styles to general.css
cat <<'EOF' >> ./book/css/general.css

/* Download button styling */
.download-btn {
    display: inline-block;
    padding: 0.75em 1.5em;
    background-color: #007bff;
    color: #fff;
    text-decoration: none;
    border-radius: 4px;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
}
.download-btn:hover {
    background-color: #0056b3;
}
EOF

echo "Appended download-button CSS to book/css/general.css"

cp ./assets/sun-logo-512.svg ./book/favicon.svg
cp ./assets/sun-logo-512.png ./book/favicon.png

# Generate sitemap.xml
SITEMAP_FILE="./book/sitemap.xml"
BASE_URL="https://wbudocs.blackberryfloat.com"

{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
  find ./book -type f -name '*.html' | while read -r file; do
    rel_path="${file#./book/}"
    url_path="${rel_path// /%20}"
    # Remove index.html from URLs for root and subdirs
    if [[ "$url_path" == "index.html" ]]; then
      url="$BASE_URL/"
    elif [[ "$url_path" == */index.html ]]; then
      url="$BASE_URL/${url_path%/index.html}/"
    else
      url="$BASE_URL/$url_path"
    fi
    echo "  <url><loc>$url</loc></url>"
  done
  echo '</urlset>'
} > "$SITEMAP_FILE"

echo "Generated sitemap.xml at $SITEMAP_FILE"