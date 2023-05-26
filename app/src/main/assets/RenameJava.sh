#!/bin/bash
#echo "Enter the path of the directory containing the files: "
#read ProjectName
ProjectName="HomeWorkout"
renamed_directory=0
percentage=0
directory="C:/AndroidProject/Test/$ProjectName/app/src/main/java"
#main_path="C:/AndroidProject/Test/$ProjectName/app/src/main"
directorieslist=(
  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/values/arrays.xml"
  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/values/attrs.xml"
  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/values/colors.xml"
  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/values/dimens.xml"
  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/values/strings.xml"
  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/values/styles.xml"
)
fun_random_string() {
  random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
  # Ensure the string doesn't start with a number or uppercase letter
  while [[ "$random_string" =~ ^[0-9A-Z] ]]; do
    random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
  done
  echo "$random_string"
}

replace_java_name() {
  random_string="$1"
  file_name_without_extension="$2"
  ProjectName="$3"
  directory="C:/AndroidProject/Test/$ProjectName/app/src/main/java"
  # Rename Java files
  find "$directory" -type f -name "*.java" -exec sed -i "s/\b${file_name_without_extension}\b/${random_string}/g" {} +
  # Rename class declaration and references
  find "$directory" -type f -name "*.java" -exec sed -i "s/\bclass ${file_name_without_extension}\b/class ${random_string}/g" {} +
  find "$directory" -type f -name "*.java" -exec sed -i "s/\b${file_name_without_extension}\.class\b/${random_string}.class/g" {} +
  find "$directory" -type f -name "*.java" -exec sed -i "s/\b${file_name_without_extension} \b/${random_string} /g" {} +
  find "$directory" -type f -name "*.java" -exec sed -i "s/\b${file_name_without_extension}<\b/${random_string}</g" {} +
}
src_files=$(find "$directory" -type f -name '*.java')
total_files=$(echo "$src_files" | wc -l)
for file in $src_files; do
  current_name_ext=$(basename "$file")
  extension="${current_name_ext##*.}"
  file_name_without_extension="${current_name_ext%.*}"
  random_string=''$file_name_without_extension'_'$(fun_random_string)''
  if [[ -f "$file" ]]; then
    replace_java_name "$random_string" "$file_name_without_extension" "$ProjectName"
    mv "$file" "$(dirname "$file")/$random_string.$extension"
    #    replace_java_import "$random_string" "$file_name_without_extension" "$directory" "$file"
    #    mv "$file" "$dir/$random_string.$extension"
  fi
  #--------------------- Calculate the percentage of files processed-------------------------
  ((renamed_directory++))
  # Calculate the percentage of files processed
  percentage=$((renamed_directory * 100 / total_files))
  echo "Progress: $percentage% ($renamed_directory/$total_files files)"
  #--------------------- Calculate the percentage of files processed-------------------------
done
