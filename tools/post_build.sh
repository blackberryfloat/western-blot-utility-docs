#!/bin/bash

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
DEST_STR='<head><script async src=\"https://www.googletagmanager.com/gtag/js?id=G-BH2MZC1S69\"></script><script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments);}gtag('js',new Date());gtag('config','G-BH2MZC1S69');</script>'
DEST_STR=$(esc_pipes "$DEST_STR")
find ./book -type f -name '*.html' -print0 | xargs -0 -I% sed -i 's|'"$SRC_STR"'|'"$DEST_STR"'|g' %
echo "Google Analytics added to all HTML files in the book directory."
