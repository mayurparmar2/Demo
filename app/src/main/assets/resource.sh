#!/bin/bash

## Output file name
#output_file="directory_names.txt"
# "Enter the path of the directory containing the files: " ProjectName
echo "Enter the path of the directory containing the files: "
read ProjectName
#C:/Users/Maniya/Desktop/MyProject/Elvee/CompleteDesign/VideoDownloader/app/src/main/res
mydi="C:/AndroidProject/$ProjectName/app/src/main/res"
main_path="C:/AndroidProject/$ProjectName/app/src/main"

directorieslist=(
  "C:/AndroidProject/$ProjectName/app/src/main/res/values"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-hdpi"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-mdpi"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-xhdpi"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-xxhdpi"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/drawable-xxxhdpi"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-hdpi"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-mdpi"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-xhdpi"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-xxhdpi"
  #  "C:/AndroidProject/$ProjectName/app/src/main/res/mipmap-xxxhdpi"
)

# Loop through the directories
for dir in "$mydi"/*; do
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

          list_java=$(grep -r --include='*.java' -l "R.$bir_name.$file_name_without_extension" "$main_path")
          for itemJava in $list_java; do
            search_pattern="R.$bir_name.$file_name_without_extension"
            replace_text="R.$bir_name.$random_string"
            find "$itemJava" -type f -exec sed -i 's/'"$search_pattern"'/'"$replace_text"'/g' {} +
            #            sed -i "s/R\.$bir_name\.$file_name_without_extension/R\.$bir_name\.$random_string/g" "$itemJava"
            echo "Search Java file Progress: $percentage% ($replaced_file/$list_java_count Directory)"
          done

          list_xml=$(grep -r --include='*.xml' -l "@$bir_name/$file_name_without_extension" "$main_path")
          for itemXml in $list_xml; do
            search_pattern="@$bir_name/$file_name_without_extension"
            replace_text="@$bir_name/$random_string"
            find "$itemXml" -type f -exec sed -i 's/'"$search_pattern"'/'"$replace_text"'/g' {} +
            #            sed -i "s/@$bir_name\/$file_name_without_extension/@$bir_name\/$random_string/g" "$itemXml"
          done
#                    list_xml_java=$(find "$java_xml_path" -type f \( -name "*.xml" -o -name "*.java" \))
#                    # Iterate over the files using a for loop
#                    for fileJava in $list_xml_java; do
#                      # Print the file path
#                       sed -Ei "s/R\.$bir_name\.$file_name_without_extension/R.$bir_name.$random_string/g" "$fileJava"
#                       sed -Ei "s/@$bir_name\/$file_name_without_extension/@$bir_name\/$random_string/g" "$fileJava"
#                    done
          mv "$file" "$dir/$random_string.$extension"
        fi
      done
    fi
  else
    echo "Directory not found: $dir"
  fi
done

#Integer.valueOf((int) R.drawable.qureka_gif)
#((int) R.drawable.placeholder)
