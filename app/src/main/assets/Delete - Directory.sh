#!/bin/bash

read -p "Enter the path of the directory containing the files: " directory

mydi="C:/AndroidProject/Test/$directory/app/src/main/res"

# List of directories to delete
directorieslist=(
  "C:/AndroidProject/Test/$directory/app/src/main/res/anim"
  "C:/AndroidProject/Test/$directory/app/src/main/res/color"
  "C:/AndroidProject/Test/$directory/app/src/main/res/font"
  "C:/AndroidProject/Test/$directory/app/src/main/res/layout"
  "C:/AndroidProject/Test/$directory/app/src/main/res/menu"
  "C:/AndroidProject/Test/$directory/app/src/main/res/xml"
  "C:/AndroidProject/Test/$directory/app/src/main/res/raw"
  "C:/AndroidProject/Test/$directory/app/src/main/res/values"
  "C:/AndroidProject/Test/$directory/app/src/main/res/drawable"
  "C:/AndroidProject/Test/$directory/app/src/main/res/drawable-hdpi"
  "C:/AndroidProject/Test/$directory/app/src/main/res/drawable-mdpi"
  "C:/AndroidProject/Test/$directory/app/src/main/res/drawable-xhdpi"
  "C:/AndroidProject/Test/$directory/app/src/main/res/drawable-xxhdpi"
  "C:/AndroidProject/Test/$directory/app/src/main/res/drawable-xxxhdpi"
  "C:/AndroidProject/Test/$directory/app/src/main/res/mipmap-hdpi"
  "C:/AndroidProject/Test/$directory/app/src/main/res/mipmap-mdpi"
  "C:/AndroidProject/Test/$directory/app/src/main/res/mipmap-xhdpi"
  "C:/AndroidProject/Test/$directory/app/src/main/res/mipmap-xxhdpi"
  "C:/AndroidProject/Test/$directory/app/src/main/res/mipmap-xxxhdpi"
)
# Loop through the directories
for dir in "$mydi"/*; do
    # Check if directory exists
    if [[ -d "$dir" ]]; then
        # Check if the directory exists in the directorieslist array
        if [[ " ${directorieslist[@]} " =~ " $dir " ]]; then
            echo "Skipping directory: $dir"
        else
            echo "Deleting directory: $dir"
            rm -r "$dir"
        fi
    else
        echo "Directory not found: $dir"
    fi
done






