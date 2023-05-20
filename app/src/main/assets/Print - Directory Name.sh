#!/bin/bash



directory="C:/Users/Mayur/Desktop/MyProjects/Demo-master/app/src/main/res"

# Output file name
output_file="directory_names.txt"

# Loop through the directories
for dir in "$directory"/*; do
  # Check if directory exists
  if [[ -d "$dir" ]]; then
   # Print the directory name with double quotes
    echo "\"$(basename "$dir")\""

    dir_name="$(basename "$dir")"
  # Append the directory name to the output file
  echo "\"C:/Users/Mayur/Desktop/MyProjects/\$directory/app/src/main/res/$dir_name\"" >> "$output_file"

  else
    echo "Directory not found: $dir"
  fi
done