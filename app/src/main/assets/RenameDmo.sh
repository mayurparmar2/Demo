#!/bin/bash

renamed_directory=0
percentage=0
directory="C:/AndroidProject/Test/VideoDownloader/app/src/main/res"
main_path="C:/AndroidProject/Test/VideoDownloader/app/src/main"
directorieslist=(
  "C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values/arrays.xml"
  "C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values/attrs.xml"
  "C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values/colors.xml"
  "C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values/dimens.xml"
  "C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values/strings.xml"
  "C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values/styles.xml"
)
fun_random_string() {
  random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
  # Ensure the string doesn't start with a number or uppercase letter
  while [[ "$random_string" =~ ^[0-9A-Z] ]]; do
    random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
  done
  echo "$random_string"
}

replace_java_files() {
  main_path="$1"
  bir_name="$2"
  file_name_without_extension="$3"
  random_string="$4"
  list_java=$(grep -r --include='*.java' -l "R.$bir_name.$file_name_without_extension" "$main_path")
  for itemJava in $list_java; do
    pattern="R.$bir_name.$file_name_without_extension"
    riplace="R.$bir_name.$random_string"
    sed -i -e "s/\b$pattern\b/$riplace/g" "$itemJava"
    #    echo "$string1 $string2" | sed -e "s/\b$string1\b/random_string/g"
    #    sed -i '0,/'$file_name_without_extension'/{s/\R\.'$bir_name'\.'$file_name_without_extension'\b/R\.'$bir_name'\.'$random_string'/}' "$itemJava"
    #    sed -i "s/R\.$bir_name\.$file_name_without_extension\([^_[:alnum:][:space:]]*\)/R.$bir_name.$random_string\1/g" "$itemJava"
  done
  list_xml=$(grep -r --include='*.xml' -l '"@'$bir_name'/'$file_name_without_extension'"' "$main_path")
  for itemXml in $list_xml; do
    sed -i "s/\"\(@$bir_name\/\)$file_name_without_extension\"/\"\1$random_string\"/g" "$itemXml"
  done
}

for dir in "$directory"/*; do
  src_files=$(find "$directory" -type f -name '*.*')
  total_files=$(echo "$src_files" | wc -l)
  # Check if directory exists
  if [[ -d "$dir" ]]; then
    bir_name="$(basename "$dir")"
    IFS='-' read -ra parts <<<"$bir_name"
    if [ "${#parts[@]}" -gt 1 ]; then
      bir_name="${parts[0]}"
    fi
    for file in "$dir"/*; do
      if [[ " ${directorieslist[@]} " =~ " $file " ]]; then
        echo "Skipping file: $dir"
      else
        current_name_ext=$(basename "$file")
        extension="${current_name_ext##*.}"
        file_name_without_extension="${current_name_ext%.*}"
        random_string=''$file_name_without_extension'_'$(fun_random_string)''
        if [[ -f "$file" ]]; then
          replace_java_files "$main_path" "$bir_name" "$file_name_without_extension" "$random_string"
          mv "$file" "$dir/$random_string.$extension"
        fi
      fi
      #--------------------- Calculate the percentage of files processed-------------------------
      ((renamed_directory++))
      # Calculate the percentage of files processed
      percentage=$((renamed_directory * 100 / total_files))
      echo "Progress: $percentage% ($renamed_directory/$total_files files)"
      #--------------------- Calculate the percentage of files processed-------------------------
    done
  fi
done

#declare -a file_list
#declare -a my_java_list
#declare -a my_xml_list
#list_and_print_files() {
#  directory="$1"
#  filename="$2"
#  new_filename="$3"
#  # Use find command to search for files with similar names
#  files=$(find "$directory" -name "${filename}.*")
#  for file in $files; do
#    #      path="${paths[$i]}"
#    if [[ " ${file_list[@]} " =~ " $file " ]]; then
#      echo "Skipping file: $file"
#    else
#      new_file="${file/$filename/$new_filename}"
#      mv "$file" "$new_file"
#      file_list+=("$new_file")
#      #      echo "Renamed file $file to $new_file"
#    fi
#  done
#}

#"s/R\.$bir_name\.$file_name_without_extension\([^_]\)/R.$bir_name.$random_string\1/g"
#R.drawable.direct_download
#itemJava="C:/AndroidProject/Test/VideoDownloader/app/src/main/java/com/demo/videodownloader/twitter_module/ui/Activity_Twitter.java"

itemJava="C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values/styles.xml"
#sed -i '0,/@drawable\/background/s//@drawable\/bottom/' "$itemJava"
sed -i 's/@drawable\/background/@drawable\/bottom/1' "$itemJava"

updated_string=$(echo "$string" | sed 's/@drawable\/bottom_sheet/@layout\/bottom/1')


string='<style name="AppModalStyle" parent="@style/Widget.Design.BottomSheet.Modal">
        <item name="android:background">@drawable/bottom_sheet</item>
 <item name="android:background">@drawable/bottom_sheet2</item>
    </style>'


echo "$updated_string"


bir_name="drawable"
file_name_without_extension="background_bottom_sheet"
random_string="new_background_bottom_sheet"
#pattern="\@$bir_name\/$file_name_without_extension"
#riplace="\@$bir_name\/$random_string"
# Perform the replacement (only the first occurrence)
updated_content=$(cat "$itemJava" | sed '0,/@'$bir_name'\/'file_name_without_extension'/s//@'$bir_name'\/'random_string'/')
# Write the updated content to a temporary file
echo "$updated_content" > "$itemJava"


sed -i '0,/@'$bir_name'\/'file_name_without_extension'/s//@'$bir_name'\/'random_string'/' "$itemJava"


string='<style name="AppModalStyle" parent="@style/Widget.Design.BottomSheet.Modal">
        <item name="android:background">@drawable/bottom_sheet</item>
 <item name="android:background">@drawable/bottom_sheet2</item>
    </style>'

sed -i '0,/@drawable\/bottom_sheet/s//@layout\/bottom/' "$string"

echo "$string"


string='<style name="AppModalStyle" parent="@style/Widget.Design.BottomSheet.Modal">
        <item name="android:background">@drawable/bottom_sheet</item>
 <item name="android:background">@drawable/bottom_sheet2</item>
    </style>'


echo "$updated_string"


sed -i "s/$pattern/$riplace\1/g" "$itemJava"

itemJava="C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values/styles.xml"
bir_name="drawable"
file_name_without_extension="background"
random_string="new_background_bottom_sheet"
pattern="\@$bir_name\/$file_name_without_extension"
riplace="\@$bir_name\/$random_string"
sed -i '0,/'$pattern' /{s/'$pattern'/'$riplace'/}' "$itemJava"

#/@drawable/background_bottom_sheet
pattern="\@drawable\/background[^<]"
riplace="\@drawable\/sdsd_bottom_sheet"
sed -i "s/$pattern/$riplace/g" "$itemJava"
sed -i 's/\>\@drawable\/background_bottom_sheet\</\>\@drawable\/new_background_bottom_sheet\</g' "$itemJava"

sed -i 's/\>\@drawable\/background_bottom_sheet\</\>\_qthqroejrd\>/' "$itemJava"

pattern="\>\@drawable\/background_bottom_sheet\<"
riplace="\>\@drawable\/_qthqroejrd\<"
sed -i "s/$pattern/$riplace/g" "$itemJava"

list_xml2=$(grep -r --include='*.xml' -l '>@'$bir_name'/'$file_name_without_extension'<' "$main_path")
for itemXml2 in $list_xml2; do
  sed -i "s/\>\(@$bir_name\/\)$file_name_without_extension\</\>\1$random_string\</g" "$itemXml2"
done




#sed -i "s/R\.drawable\.direct_download/R.drawable.direct_download_new/g" "$itemJava"
#C:\AndroidProject\Test\VideoDownloader\app\src\main\java\com\demo\videodownloader\adapter
#itemJava="C:/AndroidProject/Test/VideoDownloader/app/src/main/java/com/demo/videodownloader/adapter/Downloader_StoriesofInstagram_Adapter.java"
#sed -i '0,/itemsof/{s/\R\.layout\.itemsof_whatsapp_statuses_view\b/random_string/}' "$itemJava"
#sed -i '0,/items/{s/\bitems\b/random_string/}' filename
#
#sed -i "s/R\.layout\.items/R.layout.random_string/g" "$itemJava"
#
#echo "R.layout.R.layout.random_string_whatsapp_statuses_view" | sed -e "s/R\.layout\.activity_web_browser[^_[:alnum:][:space:]]*/R.layout.random_string/g"

#
#
#
#
#echo "R.drawable.direct_download" | sed -E "s/R\.layout\.activity_web_browser\([^_]\)/R.layout.random_string\1/g"
#
#
#echo "R.layout.activity_web_browser_list" | sed -e "s/R\.layout\.activity_web_browser\([^_]\)/R.layout.random_string\1/g"

#echo "R.layout.activity_web_browser_list" | sed -e "s/R\.layout\.activity_web_browser*\([^_]\)/R.layout.random_string\1/g"

#sed -i "s/R\.layout\.[a-zA-Z]*\([^_]\)/R.layout.random_string\1/g" WebBrowserList_Activity.java WebBrowser_Activity.java

#list_and_print_files "$main_path" "new_weather2" "weather123"
#list_and_print_files "$main_path" "new_weather2" "weather456"
#
##!/bin/bash
#
#check_item_in_list() {
#  item="$1"
#  list=("$@")
#
#  # Use conditional statement to check if the item is in the list
#  if [[ " ${list[*]} " == *" $item "* ]]; then
#    echo "Item '$item' exists in the list."
#  else
#    echo "Item '$item' does not exist in the list."
#  fi
#}
#
## Usage example
#check_item_in_list "item2" "item1" "item2" "item3"
