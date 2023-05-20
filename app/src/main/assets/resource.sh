#!/bin/bash

# "Enter the path of the directory containing the files: " ProjectName
#echo "Enter the path of the directory containing the files: "
#read ProjectName

mydi="C:/AndroidProject/Test/Demo-master/app/src/main/res"
#$mydi="C:/AndroidProject"

# Output file name
output_file="directory_names.txt"
java_xml_path="C:/AndroidProject/Test/Demo-master/app/src/main"
directorieslist=(
  "C:/AndroidProject/Test/Demo-master/app/src/main/res/values"
)

# Loop through the directories
for dir in "$mydi"/*; do
  # Check if directory exists
  if [[ -d "$dir" ]]; then
    if [[ " ${directorieslist[@]} " =~ " $dir " ]]; then
      echo "Skipping directory: $dir"
    else
      bir_name="$(basename "$dir")"
      for file in "$dir"/*; do
        # Check if the file is a directory
        if [[ -f "$file" ]]; then
          # Print file name
          current_name_ext=$(basename "$file")
          file_name_without_extension="${current_name_ext%.*}"
          # file_name_without_extension="${file_name%.*}"

          extension="${current_name_ext##*.}"
          # Generate a random string

          random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
          # Ensure the string doesn't start with a number or uppercase letter
          while [[ "$random_string" =~ ^[0-9A-Z] ]]; do
            random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
          done

          list_xml_java=$(find "$java_xml_path" -type f \( -name "*.xml" -o -name "*.java" \))
          # Iterate over the files using a for loop
          for fileJava in $list_xml_java; do
            # Print the file path
             sed -Ei "s/R\.$bir_name\.$file_name_without_extension/R.$bir_name.$random_string/g" "$fileJava"
             sed -Ei "s/@$bir_name\/$file_name_without_extension/@$bir_name\/$random_string/g" "$fileJava"
          done
          mv "$file" "$dir/$random_string.$extension"
        fi
      done
    fi
  else
    echo "Directory not found: $dir"
  fi
done

