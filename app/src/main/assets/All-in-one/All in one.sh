#!/bin/bash

# "Enter the path of the directory containing the files: " ProjectName
echo "Enter the path of the directory containing the files: "
read ProjectName

mydi="C:/AndroidProject/$ProjectName/app/src/main/res"
# Copy the file
sourceFile="C:/AndroidProject/GitHubDemo/app/src/main/res/drawable/icon200.png"
destinationDir="C:/AndroidProject/$ProjectName/app/src/main/res/drawable"
cp "$sourceFile" "$destinationDir"
echo "File copied successfully."

# Comment the file
attrsFile="C:/AndroidProject/$ProjectName/app/src/main/res/values/attrs.xml"

# Comment out all attrs
sed -i 's/<attr/<!--<attr/g; s/<\/attr>/<\/attr>-->/g' "$attrsFile"
# sed -i 's/^/<!--/; s/$/-->/' "$attrsFile"

echo "Styles in $attrsFile have been commented out."

# List of directories to delete
directorieslist=(
  "C:/AndroidProject/$ProjectName/app/src/main/res/anim"
  "C:/AndroidProject/$ProjectName/app/src/main/res/color"
  "C:/AndroidProject/$ProjectName/app/src/main/res/font"
  "C:/AndroidProject/$ProjectName/app/src/main/res/layout"
  "C:/AndroidProject/$ProjectName/app/src/main/res/menu"
  "C:/AndroidProject/$ProjectName/app/src/main/res/xml"
  "C:/AndroidProject/$ProjectName/app/src/main/res/raw"
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

directory_count=$(find $mydi -type d | wc -l)
replace_files=0
for dir in "$mydi"/*; do
  # Check if directory exists
  if [[ -d "$dir" ]]; then
    if [[ " ${directorieslist[@]} " =~ " $dir " ]]; then
      echo "Skipping directory: $dir"
    else
      rm -r "$dir"
    fi
    ((replace_files++))
    # Calculate the percentage of files processed
    percentage=$((replace_files * 100 / directory_count))
    echo "Deleting Directory Progress: $percentage% ($replace_files/$directory_count Directory)"
  else
    echo "Directory not found: $dir"
  fi
done

# Function to recursively search and delete files starting with 'abc'
delete_files() {
  local dir="$1"
  delete_files_total=$(find $dir -type f -name "*.xml" | grep -c ".*")
  # Check if the directory exists
  if [[ -d "$dir" ]]; then
    # Iterate through the contents of the directory
    for item in "$dir"/*; do
      if [[ -f "$item" && "$item" == "$dir"/abc_* ||
        "$item" == "$dir"/design_* ||
        "$item" == "$dir"/common_google* ||
        "$item" == "$dir"/m3_* ||
        "$item" == "$dir"/material_* ||
        "$item" == "$dir"/test_* ||
        "$item" == "$dir"/btn_radio_to* ||
        "$item" == "$dir"/admob_* ||
        "$item" == "$dir"/avd_* ||
        "$item" == "$dir"/ic_m3_chip* ||
        "$item" == "$dir"/res_* ||
        "$item" == "$dir"/test_* ||
        "$item" == "$dir"/notification_* ||
        "$item" == "$dir"/custom_dialog* ||
        "$item" == "$dir"/browser_* ||
        "$item" == "$dir"/select_* ||
        "$item" == "$dir"/bools* ||
        "$item" == "$dir"/integers* ||
        "$item" == "$dir"/plurals* ||
        "$item" == "$dir"/public* ||
        "$item" == "$dir"/standalone_* ||
        "$item" == "$dir"/splits0* ||
        "$item" == "$dir"/support_simple_* ||
        "$item" == "$dir"/drawables* ||
        "$item" == "$dir"/dp_example* ||
        "$item" == "$dir"/sdp_example* ||
        "$item" == "$dir"/tooltip_frame* ||
        "$item" == "$dir"/fragment_fast_out_* ||
        "$item" == "$dir"/checkbox_themeable* ||
        "$item" == "$dir"/radiobutton_themeable* ||
        "$item" == "$dir"/switch_thumb_* ||
        "$item" == "$dir"/navigation_empty_* ||
        "$item" == "$dir"/firebase_common* ||
        "$item" == "$dir"/mtrl_* ||
        "$item" == "$dir"/*_mtrl_* ||
        "$item" == "$dir"/*mtrl ||
        "$item" == "$dir"/btn_checkbox_* ]] \
        ; then
        # Delete the file starting with 'abc'
        ((delete_files_count++))
        echo "Deleting file:  ($delete_files_count/$delete_files_total Directory)"
        rm "$item"
      elif [[ -d "$item" ]]; then
        # Recursively call the function for nested directories
        delete_files "$item"
      fi
    done
  fi
}
delete_files "$mydi"

regexDir="C:/AndroidProject/$ProjectName/app/src/main/res/values"
pattern1='<(\w+)\s+[^>]*name="common_[^"]*"[^>]*>(.*?)<\/\1>'
pattern2='<(\w+)\s+[^>]*name="m3_[^"]*"[^>]*>(.*?)<\/\1>'
pattern3='<(\w+)\s+[^>]*name="bright_[^"]*"[^>]*>(.*?)<\/\1>'
pattern4='<(\w+)\s+[^>]*name="cardview_[^"]*"[^>]*>(.*?)<\/\1>'
pattern5='<(\w+)\s+[^>]*name="design_[^"]*"[^>]*>(.*?)<\/\1>'
pattern6='<(\w+)\s+[^>]*name="dim_[^"]*"[^>]*>(.*?)<\/\1>'
pattern7='<(\w+)\s+[^>]*name="foreground_[^"]*"[^>]*>(.*?)<\/\1>'
pattern8='<(\w+)\s+[^>]*name="error_[^"]*"[^>]*>(.*?)<\/\1>'
pattern9='<(\w+)\s+[^>]*name="mtrl_[^"]*"[^>]*>(.*?)<\/\1>'
pattern10='<(\w+)\s+[^>]*name="primary_[^"]*"[^>]*>(.*?)<\/\1>'
pattern11='<(\w+)\s+[^>]*name="ripple_[^"]*"[^>]*>(.*?)<\/\1>'
pattern12='<(\w+)\s+[^>]*name="secondary_[^"]*"[^>]*>(.*?)<\/\1>'
pattern13='<(\w+)\s+[^>]*name="tooltip_[^"]*"[^>]*>(.*?)<\/\1>'
pattern14='<(\w+)\s+[^>]*name="switch_[^"]*"[^>]*>(.*?)<\/\1>'
pattern15='<(\w+)\s+[^>]*name="foreground_[^"]*"[^>]*>(.*?)<\/\1>'
pattern16='<(\w+)\s+[^>]*name="material_[^"]*"[^>]*>(.*?)<\/\1>'
pattern17='<(\w+)\s+[^>]*name="browser_[^"]*"[^>]*>(.*?)<\/\1>'
pattern18='<(\w+)\s+[^>]*name="abc_[^"]*"[^>]*>(.*?)<\/\1>'
pattern19='<(\w+)\s+[^>]*name="error_[^"]*"[^>]*>(.*?)<\/\1>'
pattern20='<(\w+)\s+[^>]*name="accent_[^"]*"[^>]*>(.*?)<\/\1>'
pattern21='<(\w+)\s+[^>]*name="ripple_[^"]*"[^>]*>(.*?)<\/\1>'
pattern22='<(\w+)\s+[^>]*name="androidx_[^"]*"[^>]*>(.*?)<\/\1>'
pattern23='<(\w+)\s+[^>]*name="offline_[^"]*"[^>]*>(.*?)<\/\1>'
pattern24='<(\w+)\s+[^>]*name="path_password[^"]*"[^>]*>(.*?)<\/\1>'
pattern25='<(\w+)\s+[^>]*name="offline_[^"]*"[^>]*>(.*?)<\/\1>'
pattern26='<(\w+)\s+[^>]*name="fab_transformation[^"]*"[^>]*>(.*?)<\/\1>'
pattern27='<(\w+)\s+[^>]*name="notification_[^"]*"[^>]*>(.*?)<\/\1>'
pattern28='<(\w+)\s+[^>]*name="highlighted_[^"]*"[^>]*>(.*?)<\/\1>'
pattern29='<(\w+)\s+[^>]*name="button_material[^"]*"[^>]*>(.*?)<\/\1>'
pattern30='<(\w+)\s+[^>]*name="background_material[^"]*"[^>]*>(.*?)<\/\1>'
pattern31='<(\w+)\s+[^>]*name="background_floating[^"]*"[^>]*>(.*?)<\/\1>'
pattern32='<(\w+)\s+[^>]*name="highlighted_[^"]*"[^>]*>(.*?)<\/\1>'
pattern33='<(\w+)\s+[^>]*name="firebase_[^"]*"[^>]*>(.*?)<\/\1>'
pattern34='<(\w+)\s+[^>]*name="google_[^"]*"[^>]*>(.*?)<\/\1>'
pattern35='<(\w+)\s+[^>]*name="default_web[^"]*"[^>]*>(.*?)<\/\1>'
pattern36='<(\w+)\s+[^>]*name="test_mtrl_[^"]*"[^>]*>(.*?)<\/\1>'
pattern37='<(\w+)\s+[^>]*name="test_navigation[^"]*"[^>]*>(.*?)<\/\1>'
pattern38='<(\w+)\s+[^>]*name="test_navigation[^"]*"[^>]*>(.*?)<\/\1>'
pattern39='<(\w+)\s+[^>]*name="action_bar_size[^"]*"[^>]*>(.*?)<\/\1>'
pattern40='<(\w+)\s+[^>]*name="appcompat_dialog_background_inset[^"]*"[^>]*>(.*?)<\/\1>'
pattern41='<(\w+)\s+[^>]*name="compat_[^"]*"[^>]*>(.*?)<\/\1>'
pattern42='<(\w+)\s+[^>]*name="default_[^"]*"[^>]*>(.*?)<\/\1>'
pattern43='<(\w+)\s+[^>]*name="disabled_alpha[^"]*"[^>]*>(.*?)<\/\1>'
pattern44='<(\w+)\s+[^>]*name="fastscroll_[^"]*"[^>]*>(.*?)<\/\1>'
pattern45='<(\w+)\s+[^>]*name="highlight_[^"]*"[^>]*>(.*?)<\/\1>'
pattern46='<(\w+)\s+[^>]*name="hint_[^"]*"[^>]*>(.*?)<\/\1>'
pattern47='<(\w+)\s+[^>]*name="item_[^"]*"[^>]*>(.*?)<\/\1>'
replacement=''

file_count=$(find $regexDir -type f -name "*.xml" | grep -c ".*")
replace_files=0
# Loop through all files in the directory
for file in "$regexDir"/*; do
  if [[ -f "$file" ]]; then
    # Execute the sed command on each file
    # sed -i s/replacement/000000/g "$file"
    sed -i "s/$pattern1/$replacement/g" "$file"
    sed -i "s/$pattern2/$replacement/g" "$file"
    sed -i "s/$pattern3/$replacement/g" "$file"
    sed -i "s/$pattern4/$replacement/g" "$file"
    sed -i "s/$pattern5/$replacement/g" "$file"
    sed -i "s/$pattern6/$replacement/g" "$file"
    sed -i "s/$pattern7/$replacement/g" "$file"
    sed -i "s/$pattern9/$replacement/g" "$file"
    sed -i "s/$pattern10/$replacement/g" "$file"
    sed -i "s/$pattern11/$replacement/g" "$file"
    sed -i "s/$pattern12/$replacement/g" "$file"
    sed -i "s/$pattern13/$replacement/g" "$file"
    sed -i "s/$pattern14/$replacement/g" "$file"
    sed -i "s/$pattern15/$replacement/g" "$file"
    sed -i "s/$pattern16/$replacement/g" "$file"
    sed -i "s/$pattern17/$replacement/g" "$file"
    sed -i "s/$pattern18/$replacement/g" "$file"
    sed -i "s/$pattern19/$replacement/g" "$file"
    sed -i "s/$pattern20/$replacement/g" "$file"
    sed -i "s/$pattern21/$replacement/g" "$file"
    sed -i "s/$pattern22/$replacement/g" "$file"
    sed -i "s/$pattern23/$replacement/g" "$file"
    sed -i "s/$pattern24/$replacement/g" "$file"
    sed -i "s/$pattern25/$replacement/g" "$file"
    sed -i "s/$pattern26/$replacement/g" "$file"
    sed -i "s/$pattern27/$replacement/g" "$file"
    sed -i "s/$pattern28/$replacement/g" "$file"
    sed -i "s/$pattern29/$replacement/g" "$file"
    sed -i "s/$pattern30/$replacement/g" "$file"
    sed -i "s/$pattern31/$replacement/g" "$file"
    sed -i "s/$pattern32/$replacement/g" "$file"
    sed -i "s/$pattern33/$replacement/g" "$file"
    sed -i "s/$pattern34/$replacement/g" "$file"
    sed -i "s/$pattern35/$replacement/g" "$file"
    sed -i "s/$pattern36/$replacement/g" "$file"
    sed -i "s/$pattern37/$replacement/g" "$file"
    sed -i "s/$pattern38/$replacement/g" "$file"
    sed -i "s/$pattern39/$replacement/g" "$file"
    sed -i "s/$pattern40/$replacement/g" "$file"
    sed -i "s/$pattern41/$replacement/g" "$file"
    sed -i "s/$pattern42/$replacement/g" "$file"
    sed -i "s/$pattern43/$replacement/g" "$file"
    sed -i "s/$pattern44/$replacement/g" "$file"
    sed -i "s/$pattern45/$replacement/g" "$file"
    sed -i "s/$pattern46/$replacement/g" "$file"
    sed -i "s/$pattern47/$replacement/g" "$file"
    
    sed -i "s/android:tint=/app:tint=/g" "$file"
    sed -i 's/Of="0"/Of="parent"/g' "$file"
    sed -i 's/app:tabMode="1"/app:tabMode="fixed"/g' "$file"
    sed -i 's/app:tabMode="2"/app:tabMode="auto"/g' "$file"
    sed -i 's/app:tabMode="0"/app:tabMode="scrollable"/g' "$file"
  fi
  ((replace_files++))
  # Calculate the percentage of files processed
  percentage=$((replace_files * 100 / file_count))
  echo "replace file Progress: $percentage% ($replace_files/$file_count replaced)"
done


dirAll="C:/AndroidProject/$ProjectName/app/src/main"
list_xml_java=$(find "$dirAll" -type f \( -name "*.xml" -o -name "*.java" \))
my_style_list=()
for fileXmlJava in $list_xml_java; do
  # Print the file path
  style_name=$(grep -oP '="@style/\K[^"]+' $fileXmlJava)



  # Check if the string is not empty
  if [[ -n "$style_name" ]]; then
     is_duplicate=0
     # Check if the string is equal to any existing element in the list
     for item in "${my_style_list[@]}"; do
       if [[ "$item" == "$style_name" ]]; then
         # Set the flag if the string is a duplicate
         is_duplicate=1
         break
       fi
     done
     # Add the string to the list if it is not a duplicate
     if [[ $is_duplicate -eq 0 ]]; then
       echo "$style_name"
       item_str=${style_name//[[:space:]]/}
#       modified_string=$(echo "$item_str" | sed 's/\./\\./g')
       my_style_list+=("$item_str")
     fi
  fi
done
# Comment out all styles
stylesFile="C:/AndroidProject/$ProjectName/app/src/main/res/values/styles.xml"
commented_string=$(cat "$stylesFile" | awk '/<style name="'"$(IFS="|"; echo "${my_style_list[*]}")"'"/,/<\/style>/{print; next}{print "<!--" $0 "-->"}')
echo -e "$commented_string" > "$stylesFile"
sed -i 's/<!--<?xml version="1.0" encoding="utf-8"?>-->/<?xml version="1.0" encoding="utf-8"?>/' "$stylesFile"
sed -i 's/<!--<resources>-->/<resources>/' "$stylesFile"
sed -i 's/<!--<\/resources>-->/<\/resources>/' "$stylesFile"
