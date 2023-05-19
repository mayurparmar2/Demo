#!/bin/bash

# "Enter the path of the directory containing the files: " ProjectName
echo "Enter the path of the directory containing the files: "
read ProjectName
mydi="C:/AndroidProject/$ProjectName/app/src/main/res/values"
pattern1='<(\w+)\s+[^>]*name="common_[^"]*"[^>]*>(.*?)<\/\1>'
pattern2='<(\w+)\s+[^>]*name="m3_[^"]*"[^>]*>(.*?)<\/\1>'
pattern3='<(\w+)\s+[^>]*name="bright_[^"]*"[^>]*>(.*?)<\/\1>'
pattern4='<(\w+)\s+[^>]*name="cardview_[^"]*"[^>]*>(.*?)<\/\1>'
pattern5='<(\w+)\s+[^>]*name="design_[^"]*"[^>]*>(.*?)<\/\1>'
pattern6='<(\w+)\s+[^>]*name="dim_[^"]*"[^>]*>(.*?)<\/\1>'
pattern7='<(\w+)\s+[^>]*name="foreground_[^"]*"[^>]*>(.*?)<\/\1>'
pattern8='<(\w+)\s+[^>]*name="error_[^"]*"[^>]*>(.*?)<\/\1>'
pattern9='<(\w+)\s+[^>]*name="mtrl_[^"]*"[^>]*>(.*?)<\/\1>'
pattern10='<(\w+)\s+[^>]*name="primary_[^"]*"[^>]*>(.*?)<\/\1>'
pattern11='<(\w+)\s+[^>]*name="ripple_[^"]*"[^>]*>(.*?)<\/\1>'
pattern12='<(\w+)\s+[^>]*name="secondary_[^"]*"[^>]*>(.*?)<\/\1>'
pattern13='<(\w+)\s+[^>]*name="tooltip_[^"]*"[^>]*>(.*?)<\/\1>'
pattern14='<(\w+)\s+[^>]*name="switch_[^"]*"[^>]*>(.*?)<\/\1>'
pattern15='<(\w+)\s+[^>]*name="foreground_[^"]*"[^>]*>(.*?)<\/\1>'
pattern16='<(\w+)\s+[^>]*name="material_[^"]*"[^>]*>(.*?)<\/\1>'
pattern17='<(\w+)\s+[^>]*name="browser_[^"]*"[^>]*>(.*?)<\/\1>'
pattern18='<(\w+)\s+[^>]*name="abc_[^"]*"[^>]*>(.*?)<\/\1>'
pattern19='<(\w+)\s+[^>]*name="error_[^"]*"[^>]*>(.*?)<\/\1>'
pattern20='<(\w+)\s+[^>]*name="accent_[^"]*"[^>]*>(.*?)<\/\1>'
pattern21='<(\w+)\s+[^>]*name="ripple_[^"]*"[^>]*>(.*?)<\/\1>'
pattern22='<(\w+)\s+[^>]*name="androidx_[^"]*"[^>]*>(.*?)<\/\1>'
pattern23='<(\w+)\s+[^>]*name="offline_[^"]*"[^>]*>(.*?)<\/\1>'
pattern24='<(\w+)\s+[^>]*name="path_password[^"]*"[^>]*>(.*?)<\/\1>'
pattern25='<(\w+)\s+[^>]*name="offline_[^"]*"[^>]*>(.*?)<\/\1>'
pattern26='<(\w+)\s+[^>]*name="fab_transformation[^"]*"[^>]*>(.*?)<\/\1>'
replacement=''
# Loop through all files in the directory
for file in "$mydi"/*; do
  if [[ -f "$file" ]]; then
    # Execute the sed command on each file
#     sed -i s/replacement/000000/g "$file"
    sed -Ei "s/$pattern1/$replacement/g" "$file"
    sed -Ei "s/$pattern2/$replacement/g" "$file"
    sed -Ei "s/$pattern3/$replacement/g" "$file"
    sed -Ei "s/$pattern4/$replacement/g" "$file"
    sed -Ei "s/$pattern5/$replacement/g" "$file"
    sed -Ei "s/$pattern6/$replacement/g" "$file"
    sed -Ei "s/$pattern7/$replacement/g" "$file"
    sed -Ei "s/$pattern9/$replacement/g" "$file"
    sed -Ei "s/$pattern10/$replacement/g" "$file"
    sed -Ei "s/$pattern11/$replacement/g" "$file"
    sed -Ei "s/$pattern12/$replacement/g" "$file"
    sed -Ei "s/$pattern13/$replacement/g" "$file"
    sed -Ei "s/$pattern14/$replacement/g" "$file"
    sed -Ei "s/$pattern15/$replacement/g" "$file"
    sed -Ei "s/$pattern16/$replacement/g" "$file"
    sed -Ei "s/$pattern17/$replacement/g" "$file"
    sed -Ei "s/$pattern18/$replacement/g" "$file"
    sed -Ei "s/$pattern19/$replacement/g" "$file"
    sed -Ei "s/$pattern20/$replacement/g" "$file"
    sed -Ei "s/$pattern21/$replacement/g" "$file"
    sed -Ei "s/$pattern22/$replacement/g" "$file"
    sed -Ei "s/$pattern23/$replacement/g" "$file"
    sed -Ei "s/$pattern24/$replacement/g" "$file"
    sed -Ei "s/$pattern25/$replacement/g" "$file"
    sed -Ei "s/$pattern26/$replacement/g" "$file"
  fi
done