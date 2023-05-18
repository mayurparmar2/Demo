#!/bin/bash
# Demo-master
echo "Enter the file name to delete: "
read directory

directories=(
"C:/Users/Mayur/Desktop/MyProjects/$directory/app/src/main/res/menu"
)

# Iterate through the directories
for dir in "${directories[@]}"; do
  # Check if the directory exists
  if [[ -d "$dir" ]]; then
    # Find and delete files starting with 'abc' within the directory and its subdirectories
    for file in $(find "$dir" -type f -name 'menu*'); do
      echo "Deleting file: $file"
      rm "$file"
    done
    echo "Deleted files starting with 'abc' within directory: $dir"
  else
    echo "Directory not found: $dir"
  fi
done

#if [ -f "$filename" ]; then
  #  rm "$filename"
   # echo "File '$filename' deleted successfully."
#else
#    echo "File '$filename' does not exist."
#fi



