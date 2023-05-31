#!/bin/bash
echo "Enter the path of the directory containing the files: "
read directory

Project_main="C:/AndroidProject/$directory/app/src/main"
Project_dir="C:/AndroidProject/$directory"
source_dir="C:/AndroidProject/GithubDemo"
jadx="F:/SaveJadx/$directory"

if [ ! -d "$Project_dir" ]; then
  mkdir -p "$Project_dir"
fi
cp -r "$source_dir"/* "$Project_dir"

linkFile="$Project_dir/link.txt"
if [ ! -f "$linkFile" ]; then
  touch "$linkFile"
  echo "Link    :" >"$linkFile"
fi
manifast="$jadx/resources/AndroidManifest.xml"
pakagename=$(grep -Eo 'package="[a-z0-9_\.]+' "$manifast" | awk -F'"' '{print $NF}')
version=$(grep -Eo 'versionName="[a-z0-9_\.]+' "$manifast" | awk -F'"' '{print $NF}')
echo -e 'Link    : https://play.google.com/store/apps/details?id='$pakagename'\nPackage : '$pakagename' \nversion : '$version'' >"$linkFile"

assets="$jadx/resources/assets"
res="$jadx/resources/res"
if [ -d "$Project_main"/assets ]; then
  rm -r "$Project_main"/assets
fi
if [ -d "$Project_main"/res ]; then
  rm -r "$Project_main"/res
fi
cp -r "$assets" "$Project_main"
cp -r "$res" "$Project_main"
