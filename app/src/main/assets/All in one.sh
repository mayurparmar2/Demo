#!/bin/bash

# "Enter the path of the directory containing the files: " ProjectName
echo "Enter the path of the directory containing the files: "
read ProjectName

sourceFile="C:/AndroidProject/GitHubDemo/app/src/main/res/drawable/icon200.png"
destinationDir="C:/AndroidProject/$ProjectName/app/src/main/res/drawable"

# Copy the file
cp "$sourceFile" "$destinationDir"
echo "File copied successfully."


stylesFile="C:/AndroidProject/$ProjectName/app/src/main/res/values/styles.xml"
attrsFile="C:/AndroidProject/$ProjectName/app/src/main/res/values/attrs.xml"

# Backup the original styles.xml file
# cp "$stylesFile" "$stylesFile.bak"
# cp "$attrsFile" "$attrsFile.bak"

# Comment out all styles
sed -i 's/<style/<!--<style/g; s/<\/style>/<\/style>-->/g' "$stylesFile"

echo "Styles in $stylesFile have been commented out."

# Comment out all attrs
sed -i 's/<attr/<!--<attr/g; s/<\/attr>/<\/attr>-->/g' "$attrsFile"
# sed -i 's/^/<!--/; s/$/-->/' "$attrsFile"

echo "Styles in $attrsFile have been commented out."



# List of directories to delete
mydi="C:/AndroidProject/$ProjectName/app/src/main/res"
directorieslist=(
  "C:/AndroidProject/$ProjectName/app/src/main/res/anim"
  "C:/AndroidProject/$ProjectName/app/src/main/res/color"
  "C:/AndroidProject/$ProjectName/app/src/main/res/font"
  "C:/AndroidProject/$ProjectName/app/src/main/res/layout"
  "C:/AndroidProject/$ProjectName/app/src/main/res/menu"
  "C:/AndroidProject/$ProjectName/app/src/main/res/xml"
  "C:/AndroidProject/$ProjectName/app/src/main/res/values"
  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable"
  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-hdpi"
  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-mdpi"
  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-xhdpi"
  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-xxhdpi"
  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-xxxhdpi"
  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-hdpi"
  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-mdpi"
  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-xhdpi"
  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-xxhdpi"
  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-xxxhdpi"
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

# Function to recursively search and delete files starting with 'abc'
delete_files() {
  local dir="$1"

  # Check if the directory exists
  if [[ -d "$dir" ]]; then
    # Iterate through the contents of the directory
    for item in "$dir"/*; do
      if [[ -f "$item" && "$item" == "$dir"/abc_*
          || "$item" == "$dir"/design_*
          || "$item" == "$dir"/common_google*
          || "$item" == "$dir"/m3_*
          || "$item" == "$dir"/material_*
          || "$item" == "$dir"/mtrl_*
          || "$item" == "$dir"/test_*
          || "$item" == "$dir"/btn_*
          || "$item" == "$dir"/admob_*
          || "$item" == "$dir"/avd_*
          || "$item" == "$dir"/ic_m3_chip*
          || "$item" == "$dir"/res_*
          || "$item" == "$dir"/test_*
          || "$item" == "$dir"/notification_*
          || "$item" == "$dir"/custom_dialog*
          || "$item" == "$dir"/browser_*
          || "$item" == "$dir"/select_*
          || "$item" == "$dir"/text_view_*
          || "$item" == "$dir"/bools*
          || "$item" == "$dir"/integers*
          || "$item" == "$dir"/plurals*
          || "$item" == "$dir"/public*
          || "$item" == "$dir"/standalone_*
          || "$item" == "$dir"/splits0*
          || "$item" == "$dir"/support_simple_*
        ]]; then
        # Delete the file starting with 'abc'
        echo "Deleting file: $item"
        rm "$item"
      elif [[ -d "$item" ]]; then
        # Recursively call the function for nested directories
        delete_files "$item"
      fi
    done
  fi
}
delete_files "$mydi"









