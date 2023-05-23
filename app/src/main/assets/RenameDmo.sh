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

replace_java_files() {
  main_path="$1"
  bir_name="$2"
  file_name_without_extension="$3"
  random_string="$4"
  list_java=$(grep -r --include='*.java' -l "R.$bir_name.$file_name_without_extension" "$main_path")
  for itemJava in $list_java; do
    search_pattern="R.$bir_name.$file_name_without_extension[[:alnum:]_]*"
    replace_text="R.$bir_name.$random_string"
    find "$itemJava" -type f -exec sed -i 's/'"$search_pattern"'/'"$replace_text"'/g' {} +
  done
#
#  list_xml=$(grep -r --include='*.xml' -l "@$bir_name/$file_name_without_extension" "$main_path")
#  for itemXml in $list_xml; do
#    search_pattern="@$bir_name/$file_name_without_extension[[:alnum:]_]*"
#    replace_text="@$bir_name/$random_string"
#    find "$itemXml" -type f -exec sed -i 's/'"$search_pattern"'/'"$replace_text"'/g' {} +
#    #            sed -i "s/@$bir_name\/$file_name_without_extension/@$bir_name\/$random_string/g" "$itemXml"
#  done

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
          replace_java_files "$main_path" "$bir_name" "$file_name_without_extension" "$random_string"
          list_and_print_files "$main_path" "$file_name_without_extension" "$random_string"
        fi
      done
    fi
  fi
done

#echo "Hello, this is a sample text" | sed -e 's/\b\([a-zA-Z]*pattern[a-zA-Z]*\)\b/replacement/g'

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
