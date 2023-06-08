#!/bin/bash

#!/bin/bash

OLD_CLASS_NAME="Activity_Instagram_Stories"
NEW_CLASS_NAME="NewClassName"


directory="C:/AndroidProject/VideoDownloader/app/src/main/java"

# Rename Java files
find "$directory" -type f -name "*.java" -exec sed -i "s/\b${OLD_CLASS_NAME}\b/${NEW_CLASS_NAME}/g" {} +

# Rename class declaration and references
find "$directory" -type f -name "*.java" -exec sed -i "s/\bclass ${OLD_CLASS_NAME}\b/class ${NEW_CLASS_NAME}/g" {} +
find "$directory" -type f -name "*.java" -exec sed -i "s/\b${OLD_CLASS_NAME}\.class\b/${NEW_CLASS_NAME}.class/g" {} +
find "$directory" -type f -name "*.java" -exec sed -i "s/\b${OLD_CLASS_NAME} \b/${NEW_CLASS_NAME} /g" {} +
find "$directory" -type f -name "*.java" -exec sed -i "s/\b${OLD_CLASS_NAME}<\b/${NEW_CLASS_NAME}</g" {} +

echo "Renaming complete!"




OLD_CLASS_NAME="OldClassName"
NEW_CLASS_NAME="NewClassName"

# Rename Java files
find . -type f -name "*.java" -exec sed -i "s/\b${OLD_CLASS_NAME}\b/${NEW_CLASS_NAME}/g" {} +

# Rename class declaration and references
find . -type f -name "*.java" -exec sed -i "s/\bclass ${OLD_CLASS_NAME}\b/class ${NEW_CLASS_NAME}/g" {} +
find . -type f -name "*.java" -exec sed -i "s/\b${OLD_CLASS_NAME}\.class\b/${NEW_CLASS_NAME}.class/g" {} +
find . -type f -name "*.java" -exec sed -i "s/\b${OLD_CLASS_NAME} \b/${NEW_CLASS_NAME} /g" {} +
find . -type f -name "*.java" -exec sed -i "s/\b${OLD_CLASS_NAME}<\b/${NEW_CLASS_NAME}</g" {} +

echo "Renaming complete!"











java -cp C:\Program Files\Android\Android Studio\lib\idea_rt.jar com.intellij.rt.execution.application.AppMain com.intellij.refactoring.rename.RenameProcessor --module app --newName NewName C:\AndroidProject\Campass\app\src\main\java\com\demo\example\MainActivity.java

java -cp C:\Program Files/Android/Android Studio/lib/idea_rt.jar com.intellij.rt.execution.application.AppMain com.intellij.refactoring.rename.RenameProcessor --module app --newName NewName /app/src/main/java/com/demo/example/MainActivity.java


mv com/demo/example/MainActivity.java com/demo/example/NewClass.java

C:/AndroidProject/Campass/app/src/main/java/com/demo/example/MainActivity.java

ren app\src\main\java\com\demo\example\MainActivity.java NewFile.java
./studio.sh --disable-android-plugin --action=refactor --rename C:/AndroidProject/Campass/app/src/main/java/com/demo/example/MainActivity.java NewFile.java

C:/Program Files/Android/Android Studio/bin/sh studio.bat --disable-android-plugin --action=refactor --rename C:/AndroidProject/Campass/app/src/main/java/com/demo/example/MainActivity.java NewFile.java

studio.bat --disable-android-plugin --action=refactor --rename C:/AndroidProject/Campass/app/src/main/java/com/demo/example/MainActivity.java NewFile.java
#fun_random_string() {
#  random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 20 | head -n 1)
#  # Ensure the string doesn't start with a number or uppercase letter
#  while [[ "$random_string" =~ ^[0-9A-Z] ]]; do
#    random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 20 | head -n 1)
#  done
#  echo "$random_string"
#}
#renamed_list=()
#java_file_path="C:/AndroidProject/Test/VideoDownloader/app/src/main/res/layout"
#main_path="C:/AndroidProject/Test/VideoDownloader/app/src/main"
#directory="C:/AndroidProject/Test/VideoDownloader/app/src/main/res"
#directorieslist=(
#  "C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-hdpi"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-mdpi"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-xhdpi"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-xxhdpi"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-xxxhdpi"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-hdpi"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-mdpi"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-xhdpi"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-xxhdpi"
#  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-xxxhdpi"
#)
#directory_count=$(find $directory -type d | wc -l)
#replace_files=0
#for dir in "$directory"/*; do
#  if [[ "${directorieslist[@]}" =~ "$dir" ]]; then
#    echo "Skipping directory: $dir"
#  else
#    bir_name="$(basename "$dir")"
#    IFS='-' read -ra parts <<<"$bir_name"
#    if [ "${#parts[@]}" -gt 1 ]; then
#      bir_name="${parts[0]}"
#    fi
#    random_string=$(fun_random_string)
#    for file in "$dir"/*; do
#      current_name_ext=$(basename "$file")
#      extension="${current_name_ext##*.}"
#      file_name_without_extension="${current_name_ext%.*}"
#      if [[ -f "$file" ]]; then
#        #        str="R.$bir_name.$file_name_without_extension"
#        #        #         echo "R.$bir_name.$file_name_without_extension => $file" >> stylesFile.xml
#        #        list_java=$(grep -r --include='*.java' -l "$str" "$main_path")
#        #        for itemJava in $list_java; do
#        #          search_pattern="R.$bir_name.$file_name_without_extension"
#        #          replace_text="R.$bir_name.$random_string"
#        #          find "$itemJava" -type f -exec sed -i 's/'"$search_pattern"'/'"$replace_text"'/g' {} +
#        #        done
#
#        if [[ "$bir_name" == "drawable" || "$bir_name" == "mipmap" ]]; then
#          directory="C:/AndroidProject/Test/VideoDownloader/app/src/main/res"
#          pattern="*$file_name_without_extension*"
#          file_list=$(find "$directory" -type f -name "$pattern")
#          #          echo "Skipping drawable file: $file"  >>stylesFile.xml
#          for item_same in $file_list; do
#            # shellcheck disable=SC2199
#            # shellcheck disable=SC2076
#            if [[ "${renamed_list[@]}" != " ${item_same} " ]]; then
##              item_same_ext=$(basename "$item_same")
##              item_extension="${item_same_ext##*.}"
##              echo "$item_same => $directory/$(basename "$dir")/$random_string.$item_extension" >>stylesFile.xml
##              mv "$item_same" "$directory/$(basename "$dir")/$random_string.$item_extension"
#              renamed_list+=("$item_same")
#            echo "$item_same" >>stylesFile.xml
#            fi
#            #            item_same_ext=$(basename "$item_same")
#            #            item_extension="${item_same_ext##*.}"
#            #            echo "$item_same => $directory/$(basename "$dir")/$random_string.$item_extension" >>stylesFile.xml
#            #            mv "$item_same" "$directory/$(basename "$dir")/$random_string.$item_extension"
#          done
#          #        else
#          #           mv "$file" "$dir/$random_string.$extension"
#          #           echo "Not Skip directory: $dir"
#        fi
#        #        str="@$bir_name/$file_name_without_extension"
#        #        list_xml=$(grep -r --include='*.xml' -l "$str" "$main_path")
#        #        for itemXml in $list_xml; do
#        #          #          search_pattern="@$bir_name/$file_name_without_extension"
#        #          #          replace_text="@$bir_name/$random_string"
#        #          #          find "$itemXml" -type f -exec sed -i 's/'"$search_pattern"'/'"$replace_text"'/g' {} +
#        #          sed -i "s/@$bir_name\/$file_name_without_extension/@$bir_name\/$random_string/g" "$itemXml"
#        #        done
#        #        mv "$file" "$dir/$random_string.$extension"
#        #        echo "R.$bir_name.$file_name_without_extension" >> stylesFile.xml
#      fi
#    done
#    ((replace_files++))
#    percentage=$((replace_files * 100 / directory_count))
#    echo "Deleting Directory Progress: $percentage% ($replace_files/$directory_count Directory)"
#  fi
#done

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
