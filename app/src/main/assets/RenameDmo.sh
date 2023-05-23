#!/bin/bash

file_list=()
declare -a file_list
java_file_path="C:/AndroidProject/VideoDownloader/app/src/main/res/layout"
directory="C:/AndroidProject/VideoDownloader/app/src/main/res"
main_path="C:/AndroidProject/VideoDownloader/app/src/main"
directorieslist=(
  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable"
)

fun_random_string() {
  random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 20 | head -n 1)
  # Ensure the string doesn't start with a number or uppercase letter
  while [[ "$random_string" =~ ^[0-9A-Z] ]]; do
    random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 20 | head -n 1)
  done
  echo "$random_string"
}
list_and_print_files() {
  directory="$1"
  filename="$2"
  new_filename="$3"
  # Use find command to search for files with similar names
  files=$(find "$directory" -name "${filename}.*")
  for file in $files; do
    if [[ " ${file_list[*]} " == *" $file "* ]]; then
      echo "File '$file' is already renamed."
      break
    fi
    new_file="${file/$filename/$new_filename}"
    mv "$file" "$new_file"
    echo "Renamed file: $new_file"
  done
  file_list+=("$filename")
}
for dir in "$directory"/*; do
  directory_count=$(find $dir -type d | wc -l)
  # Check if directory exists
  if [[ -d "$dir" ]]; then
    if [[ " ${directorieslist[@]} " =~ " $dir " ]]; then
      echo "Skipping directory: $dir"
    else
      bir_name="$(basename "$dir")"
      IFS='-' read -ra parts <<<"$bir_name"
      if [ "${#parts[@]}" -gt 1 ]; then
        bir_name="${parts[0]}"
      fi
      for file in "$dir"/*; do
        current_name_ext=$(basename "$file")
        extension="${current_name_ext##*.}"
        file_name_without_extension="${current_name_ext%.*}"
        random_string=$(fun_random_string)
        if [[ -f "$file" ]]; then
          list_and_print_files "$main_path" "$file_name_without_extension" "$random_string"
#          file_same_list=$(find "$directory" -type f -name "*$file_name_without_extension*")
#          for itemSame in $file_same_list; do
#            #            if [[ ! " ${file_list[@]} " =~ " ${itemSame} " ]]; then
#            #              rename="$directory/$(basename "$dir")/$random_string.$extension"
#            echo "$itemSame" >>stylesFile.xml
#            #              mv "$itemSame" "$rename"
#            #              file_list+=("$rename")
#            #            fi
#          done
          #          echo "$file_list"
        fi
      done
      #      list_java=$(grep -r --include='*.java' -l "R.$bir_name.$file_name_without_extension" "$main_path")
    fi
  fi
done


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