#!/bin/bash


xml_file="C:/AndroidProject/StepConter/app/src/main/res/values/styles.xml"
style_list=()
manifest="C:/AndroidProject/StepConter/app/src/main/AndroidManifest.xml"
style_name=$(grep -oP 'android:theme="@style/\K[^"]+' $manifest)
style_list+=("$style_name")
echo "${style_list[@]}"
commented_string=$(cat "$xml_file" | awk '/<style name="'"$(IFS="|"; echo "${style_list[*]}")"'"/,/<\/style>/{print; next}{print "<!--" $0 "-->"}')
echo -e "$commented_string" > "$xml_file"
sed -i 's/<!--<?xml version="1.0" encoding="utf-8"?>-->/<?xml version="1.0" encoding="utf-8"?>/' "$xml_file"
sed -i 's/<!--<resources>-->/<resources>/' "$xml_file"
sed -i 's/<!--<\/resources>-->/<\/resources>/' "$xml_file"



# Function to recursively search and delete files starting with 'abc'
delete_files() {
  local dir="$1"
  file_count=$(find $dir -type f -name "*.xml" | grep -c ".*")
  replace_files=0

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
        "$item" == "$dir"/text_view_* ||
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
        "$item" == "$dir"/*_mtrl ||
        "$item" == "$dir"/btn_checkbox_* ]] \
        ; then
        # Delete the file starting with 'abc'
#        echo "Deleting file: $item"
        rm "$item"
      elif [[ -d "$item" ]]; then
        # Recursively call the function for nested directories
        delete_files "$item"
      fi
      ((replace_files++))
      # Calculate the percentage of files processed
      percentage=$((replace_files * 100 / file_count))
      echo "Deleting file Progress: $percentage% ($replace_files/$file_count files)"
    done
  fi
}

#----------------------commented_styles sucess--------------------------
#file="C:/AndroidProject/StepConter/app/src/main/res/values/styles.xml"
#commented_string=$(cat "$file" | awk '/<style name="AppTheme"/,/<\/style>/{print; next}{print "<!--" $0 "-->"}')
#
#echo "$commented_string" > "$file"
#echo "$commented_string" > commented_styles.xml
#------------------------------------------------
#set +H  # Disable history expansion
#manifest="C:/AndroidProject/StepConter/app/src/main/AndroidManifest.xml"
#style_name=$(grep -oP 'android:theme="@style/\K[^"]+' $manifest)
#echo "Theme theme_name => '$style_name'"
#style_name="AppTheme"
#file="C:/AndroidProject/StepConter/app/src/main/res/values/styles.xml"
# if [[ -f "$file" ]]; then
#    echo "style.xml file is found"
#fi
#echo "Theme theme_name => '$style_name'"
#------------------------------------------------
#sed -i "/<style name=\"$style_name\"/,/<\/style>/ s/^<!--\([^!]*\)-->$/\1/" "$xml_file"
#sed -i "/<style name=\"$style_name\">/,/<\/style>/ s/^<!--\(.*\)-->/\1/" "$xml_file"
#------------------------------------------------
#ProjectName='AutoMoveSdcard'
#java_file_path="C:/AndroidProject/$ProjectName/app/src/main/java/auto/move/to/sd/card/quick/transfer/utils/NotifiactionUtilsMove.java"
##notification_channel="new NotificationChannel(Ostr3423, Mst4242r2, 2)"
#notification_channel=$(cat "$java_file_path" | grep -o -P "new NotificationChannel\(([^)]+)\)")
#regex="new NotificationChannel\(([^,]+),\s*([^,]+),\s*([^)]+)\)"
#echo "notification_channel : $notification_channel"
#echo "regex : $regex"
#if [[ $notification_channel =~ $regex ]]; then
#  parameter1=${BASH_REMATCH[1]}
#  parameter2=${BASH_REMATCH[2]}
#  parameter3=${BASH_REMATCH[3]}
#
#    parameter1=${parameter1//[[:space:]]/}
#    parameter2=${parameter2//[[:space:]]/}
#    parameter3=${parameter3//[[:space:]]/}
##  sed -i "s/new NotificationChannel($parameter1, $parameter2, 2)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_LOW)/g" "$java_file_path"
#  sed -i "s/new NotificationChannel($parameter1, $parameter2, 2)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_LOW)/g" "$java_file_path"
#  echo "Parameter 1: $parameter1"
#  echo "Parameter 2: $parameter2"
#  echo "Parameter 3: $parameter3"
#  echo "Parameter 4: new NotificationChannel($parameter1,$parameter2,2)"
#fi

#------------------------------------------------
# "Enter the path of the directory containing the files: " ProjectName
#echo "Enter the PakageName: "
#read PakageName
#
#echo "Enter the ProjectName: "
#read ProjectName

#search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
#rPakageName="import $PakageName.R;"

#PakageName='auto.move.to.sd.card.quick.transfer'
#ProjectName='AutoMoveSdcard'
##search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
##java_files=$(find "$search_path" -type f -name '*.java')
##
##for file in $java_files; do
##  sed -i 's/268435456/Intent.FLAG_ACTIVITY_NEW_TASK/g' "$file"
##done
#
#search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
#java_files=$(find "$search_path" -type f -name '*.java')
#
#total_files=$(echo "$java_files" | wc -l)
#replace_files=0
#
#for file in $java_files; do
#  sed -i 's/268435456/Intent.FLAG_ACTIVITY_NEW_TASK/g' "$file"
#  ((replace_files++))
#
#  # Calculate the percentage of files processed
#  percentage=$((replace_files * 100 / total_files))
#  echo "Progress: $percentage% ($replace_files/$total_files files)"
#done
#
#echo "Total files: $total_files"
#echo "Files replaced: $replace_files"
#echo "Percentage processed: $percentage%"
#



