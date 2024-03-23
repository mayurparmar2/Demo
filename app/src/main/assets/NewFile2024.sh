#!/bin/bash

#run

  # cd "C:\Users\parma\OneDrive\Desktop\MyDemos\RenameFilesDemo\app\src\main\assets\"
  # ./NewFile2024.sh
#echo "Enter the path of the directory containing the files: "
#read ProjectName
ProjectName="PhotoMixerV117"
renamed_directory=0
percentage=0
directory="F:/AndroidProject/Test/$ProjectName/app/src/main/java"
layout_directory="F:/AndroidProject/Test/$ProjectName/app/src/main/res/layout"
manifest_file="F:/AndroidProject/Test/$ProjectName/app/src/main/AndroidManifest.xml"
#main_path="F:/AndroidProject/Test/$ProjectName/app/src/main"
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
replace_java_name() {
    #---------------------Start replace_java_name-------------------------
  random_string="$1"
  file_name_without_extension="$2"
  main_path="$3"
  main_file="$4"
  list_java=$(grep -r --include='*.java' -l "\b$file_name_without_extension\b" "$main_path")
  for itemJava in $list_java; do
    #    echo "$itemJava"
     sed -i '/import [^;]*;/! s/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
  done
  package="$(echo "${main_file%/*}" | sed 's|[^;]*/app/src/main/java/||g' | sed 's|/|.|g')"
  list_java2=$(grep -r --include='*.java' -l "$package" "$main_path")
  for itemJava2 in $list_java2; do
       echo -e "Package =>  $package \n File =>  $itemJava2 To => $random_string" >>name.xml
#       package="$(echo "${itemJava2%/*}" | sed 's|[^;]*/app/src/main/java/||g' | sed 's|/|.|g')"
     sed -i "s/import $package.$file_name_without_extension/import $package.$random_string/g" "$itemJava2"
#      sed -i -e "/package [^;]*;/! s/import $package.$file_name_without_extension;/import $package.$random_string;/g" "$itemJava2"
  done
      #--------------------- End replace_java_name-------------------------
}



src_files=$(find "$directory" -type f -name '*.*')
total_files=$(echo "$src_files" | wc -l)

for file in $src_files; do
  current_name_ext=$(basename "$file")
  extension="${current_name_ext##*.}"
  file_name_without_extension="${current_name_ext%.*}"
  random_string=''$file_name_without_extension'_'$(fun_random_string)''
  if [[ -f "$file" ]]; then
#    replace_java_name "$random_string" "$file_name_without_extension" "$directory" "$file"

#   echo "file : $file"
    mv "$(dirname "$file")/$file_name_without_extension.java" "$(dirname "$file")/$random_string.$extension"
    mv "$(dirname "$file")/$file_name_without_extension.kt" "$(dirname "$file")/$random_string.$extension"

#    echo "old_class_name => $file_name_without_extension, new_class_name=> $random_string"

#    grep -rl --include \*.java "$file_name_without_extension" "$directory" | xargs sed -i "s/\b$file_name_without_extension\b/$random_string/g"
    grep -rl --include \*.java --include \*.kt --include \*.xml "$file_name_without_extension" "$layout_directory" "$directory" "$manifest_file" | xargs sed -i "s/\b$file_name_without_extension\b/$random_string/g"
#    grep -rl --include \*.xml  "$file_name_without_extension" "$layout_directory" "$manifest_file" | xargs sed -i "s/\b$file_name_without_extension\b/$random_string/g"

#    grep -rl --include \*.java --include \*.kt --include \*.xml "$old_class_name" "$directory_path" "$manifest_file" | xargs sed -i "s/\b$old_class_name\b/$new_class_name/g"
  fi
  #--------------------- Calculate the percentage of files processed-------------------------
  ((renamed_directory++))
  # Calculate the percentage of files processed
  percentage=$((renamed_directory * 100 / total_files))
  echo "Progress: $percentage% ($renamed_directory/$total_files files)"
  #--------------------- Calculate the percentage of files processed-------------------------
done



#file : F:/AndroidProject/Test/PhotoMixerV117/app/src/main/java/com/demo/myblendphotors/tools/ImageUtils.java
#old_class_name => ImageUtils, new_class_name=> ImageUtils_max


#F:/AndroidProject/Test/PhotoMixerV117/app/src/main/java/com/demo/myblendphotors/tools/ImageUtils.java :
#F:/AndroidProject/Test/PhotoMixerV117/app/src/main/java/com/demo/myblendphotors/tools/ImageUtils.java
#


##!/bin/bash
#directory="C:/Users/parma/OneDrive/Desktop/MyDemos/RenameFilesDemo/app/src/main/java/com/demo/example"
#
#old_class_name="MainActivity"
#new_class_name="NewClassName"
#
## Rename the Java class file
#mv "$directory/$old_class_name.java" "$directory/$new_class_name.java"
#
## Replace occurrences of the old class name with the new class name in Java files within the directory path
#grep -rl --include \*.java "$old_class_name" "$directory" | xargs sed -i "s/$old_class_name/$new_class_name/g"
