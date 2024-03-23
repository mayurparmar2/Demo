#!/bin/bash
#echo "Enter the path of the directory containing the files: "
#read ProjectName
ProjectName="PhotoMixerV117"

  # cd "C:\Users\parma\OneDrive\Desktop\MyDemos\RenameFilesDemo\app\src\main\assets\"
  # ./RenameFileResorces2024.sh

renamed_directory=0
percentage=0
directory="F:/AndroidProject/Test/$ProjectName/app/src/main/res"
main_path="F:/AndroidProject/Test/$ProjectName/app/src/main"
directorieslist=(
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/arrays.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/attrs.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/colors.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/dimens.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/strings.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/styles.xml"
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
  main_path="F:/AndroidProject/Test/$ProjectName/app/src/main"
  list_xml=$(grep -r --include='*.xml' -l '>@'$bir_name'/'$file_name_without_extension'<' "$main_path")
  for itemXml in $list_xml; do
    pattern="@$bir_name/$file_name_without_extension"
    replacement="@$bir_name/$random_string"
    sed -i "s,>$pattern<,>$replacement<,g" "$itemXml"
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
#        random_string=''$file_name_without_extension'_'$(fun_random_string)''
        random_string=''$file_name_without_extension'_max'
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
