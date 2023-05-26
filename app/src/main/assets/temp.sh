#!/bin/bash

ProjectName="Demo-master"
# Define the paths to your Android project

#--------------------working-------------------------
ANDROID_PROJECT_PATH="C:/AndroidProject/Test/$ProjectName"
JAVA_SRC_PATH="$ANDROID_PROJECT_PATH/app/src/main/java"
RES_PATH="$ANDROID_PROJECT_PATH/app/src/main/res"

# Function to check if a resource is used
is_resource_used() {
    local resource_name="$1"
    local resource_type="$2"

    # Check Java files
    local java_usage=$(grep -r -l "R\.$resource_type\.$resource_name" "$JAVA_SRC_PATH")
    if [ -n "$java_usage" ]; then
        return 0  # Resource is used in Java files
    fi

    # Check XML files
#    local xml_usage=$(grep -r -l "@$resource_type/$resource_name" "$RES_PATH")
#    if [ -n "$xml_usage" ]; then
#        return 0  # Resource is used in XML files
#    fi

    return 1  # Resource is not used
}

# Loop through all resource files and delete unused ones
find "$RES_PATH" -type f | while read -r resource_file; do
    if [[ $resource_file =~ .*/([^/]+)/([^/]+)\.([^/.]+)$ ]]; then
        resource_type="${BASH_REMATCH[1]}"
        resource_name="${BASH_REMATCH[2]}"
        resource_extension="${BASH_REMATCH[3]}"

        if ! is_resource_used "$resource_name" "$resource_type"; then
            echo "Deleting $resource_file"
            rm "$resource_file"
        fi
    fi
done
#-------------------- Generate a list of used XML files-------------------------
#used_xml_files=$(grep -roh --include="*.java" "R\.layout\.[a-zA-Z0-9_]\+" "$JAVA_SRC_PATH" | sed 's/R.layout.//')
## Delete unused XML files
#find "$RES_PATH" -name '*.xml' | while read -r xml_file; do
#    xml_file_name=$(basename "$xml_file" .xml)
#    if ! grep -q "$xml_file_name" <<< "$used_xml_files"; then
#        echo "Deleting $xml_file"
#        rm "$xml_file"
#    fi
#done
#---------------------Toast.makeText-------------------------
#xml_refs=$(find "$JAVA_SRC_PATH" -name '*.java' -exec grep -Eo 'R\.([a-z]+\.)*[a-z]+\.[a-z]+' {} + | awk -F'.' '{print $NF}')
#
## Delete unused XML files
#find "$RES_PATH" -name '*.xml' | while read -r xml_file; do
#    xml_file_name=$(basename "$xml_file" .xml)
#    if ! grep -q "$xml_file_name" <<< "$xml_refs"; then
#        echo "Deleting $xml_file"
#        rm "$xml_file"
#    fi
#done
#

##echo "Enter the path of the directory containing the files: "
##read ProjectName
#ProjectName="Demo-master"
#directory="C:/AndroidProject/Test/$ProjectName/app/src/main/res"
#main_path="C:/AndroidProject/Test/$ProjectName/app/src/main"
#check_lists_empty() {
#  local list1=("$1") # Convert first list argument to an array
#  local list2=("$2") # Convert second list argument to an array
#  if [ "${#list1[@]}" -eq 0 ] && [ "${#list2[@]}" -eq 0 ]; then
#    return 0 # One or both lists are empty
#  else
#    return 1 # Both lists are not empty
#  fi
#}
##directorieslist=(
##  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/layout"
##)
###for itemJava in directorieslist/*; do
###  list_java=$(grep -r --include='*.java' -l "R.layout.$file_name_without_extension" "$main_path")
###
###done
#demo="C:/AndroidProject/Test/Demo-master/app/src/main/res/anim"
#for item in "$demo"/*; do
#  current_name_ext=$(basename "$item")
#  file_name_without_extension="${current_name_ext%.*}"
#  list_xml=$(grep -r --include='*.xml' -l '@anim/'$file_name_without_extension'' "$demo")
#  for file in "$item"/*; do
#    echo "file=>$file"
#  done
#  echo "item=>$item"
#done
#
#for dir in "$directory"/*; do
#  src_files=$(find "$directory" -type f -name '*.*')
#  total_files=$(echo "$src_files" | wc -l)
#  # Check if directory exists
#  if [[ -d "$dir" ]]; then
#    bir_name="$(basename "$dir")"
#    IFS='-' read -ra parts <<<"$bir_name"
#    if [ "${#parts[@]}" -gt 1 ]; then
#      bir_name="${parts[0]}"
#    fi
#    for file in "$dir"/*; do
#      current_name_ext=$(basename "$file")
#      extension="${current_name_ext##*.}"
#      file_name_without_extension="${current_name_ext%.*}"
#      #        random_string=''$file_name_without_extension'_'$(fun_random_string)''
#      if [[ -f "$file" ]]; then
#        #        list_java=$(grep -r --include='*.java' -l "R.$bir_name.$file_name_without_extension" "$main_path")
#        list_xml=$(grep -r --include='*.xml' -l '@'$bir_name'/'$file_name_without_extension'' "$main_path")
#        for list_xml in list_xml; do
#          list_java=$(grep -r --include='*.java' -l "R.layout.$file_name_without_extension" "$main_path")
#
#        done
#
#        echo "list_java=> $(echo "$list_java" | wc -l)"
#        echo "list_xml=> $(echo "$list_xml" | wc -l)"
#        if [ "${#list_java[@]}" -eq 0 ] && [ "${#list_xml[@]}" -eq 0 ]; then
#          rm "$file"
#        fi
#        #          if check_lists_empty "${list_java[@]}" "${list_xml[@]}"; then
#        #            echo "$file"
#        #
#        #          fi
#        #          mv "$file" "$dir/$random_string.$extension"
#      fi
#      #--------------------- Calculate the percentage of files processed-------------------------
#      ((renamed_directory++))
#      # Calculate the percentage of files processed
#      percentage=$((renamed_directory * 100 / total_files))
#      echo "Progress: $percentage% ($renamed_directory/$total_files files)"
#      #--------------------- Calculate the percentage of files processed-------------------------
#    done
#  fi
#done

#---------------------Toast.makeText-------------------------
#file="C:/AndroidProject/StepCounter/app/src/main/java/pedometer/stepcounter/appcompany/BMI_Calculator_Activity.java"
#matches=()
# while IFS= read -r line; do
#     matches+=("$line")
# done < <(grep -o 'Toast\.makeText([^;]*);' "$file")
# for match in "${matches[@]}"; do
#     echo "$match"
#     # Remove leading and trailing whitespace
#     string=$(echo "$match" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
#     # Extract parameters
#     IFS=',' read -r -a params <<< "${string#Toast.makeText(}"
#     context=$(echo "${params[0]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
#     message=$(echo "${params[1]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
##     duration=$(echo "${params[2]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/)//')
#    sed -i "s/Toast.makeText($context, $message, 0)/Toast.makeText($context, $message, Toast\.LENGTH_SHORT)/g" "$file"
#    sed -i "s/Toast.makeText($context, $message, 1)/Toast.makeText($context, $message, Toast\.LENGTH_LONG)/g" "$file"
# done

#----------------------Toast.makeText--------------------------
#directory="C:/AndroidProject/Test/VideoDownloader/app/src/main/res"
#pattern="*btn*"
#file_list=$(find "$directory" -type f -name "$pattern")
#echo "$file_list"

#directory="C:/AndroidProject/VideoDownloader/app/src/main/java/com/demo/videodownloader/activity/Downloader_WebBrowserList_Activity.java"
#search_pattern="R.layout.activity_web_browser_list"
#replace_text="R.layout.dvmfsphrpa"
#find "$directory" -type f -exec sed -i 's/'"$search_pattern"'/'"$replace_text"'/g' {} +
#for file in "$java_file_path"/*; do
#  if [[ -f "$file" ]]; then
#    current_name_ext=$(basename "$file")
#    file_name_without_extension="${current_name_ext%.*}"
#    echo "$file_name_without_extension"
#    list_java=$(grep -r --include='*.java' -l "R.layout.$file_name_without_extension" "$main_path")
#    echo "$list_java => $file_name_without_extension" >>stylesFile.xml
#    for itemJava in $list_java; do
#      sed -i "s/R\.layout\.$file_name_without_extension/R\.layout\.new_$file_name_without_extension/g" "$itemJava"
#    done
#  fi
#done
#
##file_list=$(grep -r --include='*.java' "R.style." "$java_file_path" | grep -o "R.style\.[a-zA-Z_][a-zA-Z0-9_]*")
#file_list=$(grep -r --include='*.java' -l "R.style." "$java_file_path")
## Print the list of R.style. references
#echo "$file_list" >stylesFile.xml
#
##
## Search for Java files and extract R.style. references
##file_list=$(grep -r "R.style." "$java_file_path" | grep -o "R.style\.[a-zA-Z_][a-zA-Z0-9_]*")
#reference=$(grep -oP 'R.style\.[a-zA-Z_][a-zA-Z0-9_]*' $java_file_path)
## Print the list of R.style. references
#
#name="${reference##*.}"
#modified_string=$(echo "$name" | sed 's/\_/\./g')
#echo "$modified_string"
#

#
#
#dirAll="C:/AndroidProject/StepConter/app/src/main"
#list_xml_java=$(find "$dirAll" -type f \( -name "*.xml" -o -name "*.java" \))
#my_style_list=()
#for fileXmlJava in $list_xml_java; do
#  # Print the file path
#  style_name=$(grep -oP '="@style/\K[^"]+' $fileXmlJava)
#  if [ -z "$style_name" ]; then
#    reference=$(grep -oP 'R.style\.[a-zA-Z_][a-zA-Z0-9_]*' $java_file_path)
#    name="${reference##*.}"
#    style_name=$(echo "$name" | sed 's/\_/\./g')
#    echo "Java: $style_name"
#  fi
#  # Check if the string is not empty
#  if [[ -n "$style_name" ]]; then
#     is_duplicate=0
#     # Check if the string is equal to any existing element in the list
#     for item in "${my_style_list[@]}"; do
#       if [[ "$item" == "$style_name" ]]; then
#         # Set the flag if the string is a duplicate
#         is_duplicate=1
#         break
#       fi
#     done
#     # Add the string to the list if it is not a duplicate
#     if [[ $is_duplicate -eq 0 ]]; then
#       echo "$style_name"
#       item_str=${style_name//[[:space:]]/}
##       modified_string=$(echo "$item_str" | sed 's/\./\\./g')
#       my_style_list+=("$item_str")
#     fi
#  fi
#done
## Comment out all styles
#stylesFile="C:/AndroidProject/StepConter/app/src/main/res/values/styles.xml"
#commented_string=$(cat "$stylesFile" | awk '/<style name="'"$(IFS="|"; echo "${my_style_list[*]}")"'"/,/<\/style>/{print; next}{print "<!--" $0 "-->"}')
#echo -e "$commented_string" > "$stylesFile"
#sed -i 's/<!--<?xml version="1.0" encoding="utf-8"?>-->/<?xml version="1.0" encoding="utf-8"?>/' "$stylesFile"
#sed -i 's/<!--<resources>-->/<resources>/' "$stylesFile"
#sed -i 's/<!--<\/resources>-->/<\/resources>/' "$stylesFile"
#

#dir="C:/AndroidProject/StepConter/app/src/main"
#list_xml_java=$(find "$dir" -type f \( -name "*.xml" -o -name "*.java" \))
#my_style_list=()
#for fileXmlJava in $list_xml_java; do
#  # Print the file path
#  style_name=$(grep -oP '="@style/\K[^"]+' $fileXmlJava)
#  # Check if the string is not empty
#  if [[ -n "$style_name" ]]; then
#     is_duplicate=0
#     # Check if the string is equal to any existing element in the list
#     for item in "${my_style_list[@]}"; do
#       if [[ "$item" == "$style_name" ]]; then
#         # Set the flag if the string is a duplicate
#         is_duplicate=1
#         break
#       fi
#     done
#     # Add the string to the list if it is not a duplicate
#     if [[ $is_duplicate -eq 0 ]]; then
#       echo "$style_name"
##       my_style_list+=("$style_name")
#     fi
#  fi
#done

#----------------------Search for Java files and extract R.style. references--------------------------
#directory="/path/to/directory"
## Search for Java files and extract R.style. references
#file_list=$(grep -r --include='*.java' "R.style." "$directory" | grep -o "R.style\.[a-zA-Z_][a-zA-Z0-9_]*")
## Print the list of R.style. references
#echo "$file_list"
#----------------------commented_styles sucess--------------------------
#dir="C:/AndroidProject/StepConter/app/src/main"
#list_xml_java=$(find "$dir" -type f \( -name "*.xml" -o -name "*.java" \))
#my_style_list=()
#for fileXmlJava in $list_xml_java; do
#  # Print the file path
#  style_name=$(grep -oP '="@style/\K[^"]+' $fileXmlJava)
## Check if the string is not empty
#  if [[ -n "$style_name" ]]; then
#    echo "$style_name"
#    my_style_list+=("$style_name")
#  fi
#done
#----------------------commented_styles sucess--------------------------
#xml_file="C:/AndroidProject/StepConter/app/src/main/res/values/styles.xml"
#style_list=()
#manifest="C:/AndroidProject/StepConter/app/src/main/AndroidManifest.xml"
#style_name=$(grep -oP 'android:theme="@style/\K[^"]+' $manifest)
#style_list+=("$style_name")
#echo "${style_list[@]}"
#commented_string=$(cat "$xml_file" | awk '/<style name="'"$(IFS="|"; echo "${style_list[*]}")"'"/,/<\/style>/{print; next}{print "<!--" $0 "-->"}')
#echo -e "$commented_string" > "$xml_file"
#sed -i 's/<!--<?xml version="1.0" encoding="utf-8"?>-->/<?xml version="1.0" encoding="utf-8"?>/' "$xml_file"
#sed -i 's/<!--<resources>-->/<resources>/' "$xml_file"
#sed -i 's/<!--<\/resources>-->/<\/resources>/' "$xml_file"
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
#java_file_path="C:/AndroidProject/StepConter/app/src/main/java/auto/move/to/sd/card/quick/transfer/utils/NotifiactionUtilsMove.java"
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
