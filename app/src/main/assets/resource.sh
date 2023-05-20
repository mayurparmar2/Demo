#!/bin/bash

# "Enter the path of the directory containing the files: " ProjectName
#echo "Enter the path of the directory containing the files: "
#read ProjectName

mydi="C:/AndroidProject/Demo-master/app/src/main/res"
#$mydi="C:/AndroidProject"

# Output file name
output_file="directory_names.txt"

directorieslist=(
  "C:/AndroidProject/Demo-master/app/src/main/res/values"
)

# Loop through the directories
for dir in "$mydi"/*; do
  # Check if directory exists
  if [[ -d "$dir" ]]; then

    bir_name="$(basename "$dir")"
    if [[ " ${directorieslist[@]} " =~ " $dir " ]]; then
      echo "Skipping directory: $dir"
    else

      for file in "$dir"/*; do
        # Check if the file is a directory
        if [[ -f "$file" ]]; then
          # Print file name
          file_name=$(basename "$file")
          file_name_without_extension="${file_name%.*}"
          echo "$bir_name\\$(basename "$file_name_without_extension")\"" >>"$output_file"
        fi
      done
      #      echo "Directory found Name:$bir_name\"" >>"$output_file"
      #      echo "Directory found Name: $dir"
      #      echo "Directory found Name:$(basename "$dir")\"" >>"$output_file"
    fi
  else
    echo "Directory not found: $dir"
  fi
done

# Iterate over each file in the directory
#for file in "$mydi"/*; do
#    # Extract the directory name without the path using basename
#    basename=$(basename "$(dirname "$file")")
#    dir_name="$(basename "$dir")"
#    # Print the directory name
#    echo "basename :$basename"
#    echo "dir_name :$dir_name"
#done
#
## Loop through the directories

#  # Loop through the directories
#  for dir in "$mydi"/*; do
#    # Check if directory exists
#    if [[ -d "$dir" ]]; then
#     # Print the directory name with double quotes
#
#      dir_name="$(basename "$dir")"
#
#      echo "Directory not found:$dir\"" >> "$output_file"
#    # Append the directory name to the output file
#
#
#    else
#    fi
#  done

#
#
#for dir in "$mydi"/*; do
#  dir_name="$(basename "$dir")"
#  #   Check if directory exists
#  if [[ -d "$dir" ]]; then
#    directoryNaem="$dir"
#    for item in "$dir"/*; do
#      # Check if the directory exists in the directorieslist array
#      if [[ " ${directorieslist[@]} " =~ " $dir " ]]; then
#        echo "Skipping directory: $dir"
#      else
#        if [[ -f "$item" ]]; then
#          echo "$directoryNaem\\$item"
#          # echo "\"C:/Users/Mayur/Desktop/MyProjects/\$directory/app/src/main/res/$dir_name\"" >> "$output_file"
#        fi
#        #        rm -r "$dir"
#      fi
#    done
#  else
#    echo "Directory not found: $dir"
#  fi
#done
