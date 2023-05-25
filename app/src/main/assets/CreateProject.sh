#!/bin/bash
echo "Enter the path of the directory containing the files: "
read directory

Project_main="C:/AndroidProject/$directory/app/src/main"
Project_dir="C:/AndroidProject/$directory"
# Specify the destination directory
source_dir="C:/AndroidProject/GithubDemo"
if [ ! -d "$Project_main" ]; then
  mkdir -p "$Project_dir"
fi
cp -r "$source_dir"/* "$Project_dir"

# Specify the source directory
assets="D:/SaveJadx/$directory/resources/assets"
res="D:/SaveJadx/$directory/resources/res"
if [ -d "$Project_main"/assets ]; then
  rm -r "$Project_main"/assets
fi
if [ -d "$Project_main"/res ]; then
  rm -r "$Project_main"/res
fi
cp -r "$assets" "$Project_main"
cp -r "$res" "$Project_main"






