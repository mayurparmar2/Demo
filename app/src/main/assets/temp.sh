#!/bin/bash
# WifiAutoConnect

# "Enter the path of the directory containing the files: " ProjectName
#echo "Enter the PakageName: "
#read PakageName
#
#echo "Enter the ProjectName: "
#read ProjectName

#search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
#rPakageName="import $PakageName.R;"

PakageName='auto.move.to.sd.card.quick.transfer'
ProjectName='AutoMoveSdcard'
#search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
#java_files=$(find "$search_path" -type f -name '*.java')
#
#for file in $java_files; do
#  sed -i 's/268435456/Intent.FLAG_ACTIVITY_NEW_TASK/g' "$file"
#done

search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
java_files=$(find "$search_path" -type f -name '*.java')

total_files=$(echo "$java_files" | wc -l)
replace_files=0

for file in $java_files; do
  sed -i 's/268435456/Intent.FLAG_ACTIVITY_NEW_TASK/g' "$file"
  ((replace_files++))

  # Calculate the percentage of files processed
  percentage=$((replace_files * 100 / total_files))
  echo "Progress: $percentage% ($replace_files/$total_files files)"
done

echo "Total files: $total_files"
echo "Files replaced: $replace_files"
echo "Percentage processed: $percentage%"


