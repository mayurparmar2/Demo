#!/bin/bash
#echo "Enter the path of the directory containing the files: "
#read ProjectName
ProjectName="HomeWorkout"
renamed_directory=0
percentage=0
directory="C:/AndroidProject/Test/$ProjectName/app/src/main/java"
fun_random_string() {
  random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
  while [[ "$random_string" =~ ^[0-9A-Z] ]]; do
    random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
  done
  echo "$random_string"
}
replace_java_name() {
  random_string="$1"
  file_name_without_extension="$2"
  main_path="$3"
  list_java=$(grep -r --include='*.java' -l "\b$file_name_without_extension\b" "$main_path")
  for itemJava in $list_java; do
    sed -i '/import [^;]*;/! s/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
    #    javas=$(find . -regex '.*\.java$')
    #    perl-rename 's;\b(?!Kt)(\w+[.]java)$;Kt$1;' $(echo $javas)
    #    sed -i -E "$(printf 's/\\<(%s)\\>/Kt\\1/g;' $(grep -hrPo '\b(class|interface|record|enum) (?!Kt)(?!List\b)(?!Entry\b)\K[A-Z]\w+'))" $(echo $javas)
  done
}
src_files=$(find "$directory" -type f -name '*.java')
total_files=$(echo "$src_files" | wc -l)
for file in $src_files; do
  current_name_ext=$(basename "$file")
  extension="${current_name_ext##*.}"
  file_name_without_extension="${current_name_ext%.*}"
  random_string=''$file_name_without_extension'_'$(fun_random_string)''
  if [[ -f "$file" ]]; then
    replace_java_name "$random_string" "$file_name_without_extension" "$directory"
    mv "$file" "$(dirname "$file")/$random_string.$extension"
  fi
  ((renamed_directory++))
  percentage=$((renamed_directory * 100 / total_files))
  echo "Progress: $percentage% ($renamed_directory/$total_files files)"
done
