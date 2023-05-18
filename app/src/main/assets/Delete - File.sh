#!/bin/bash

# Function to recursively search and delete files starting with 'abc'
delete_files() {
  local dir="$1"
  
  # Check if the directory exists
  if [[ -d "$dir" ]]; then
    # Iterate through the contents of the directory
    for item in "$dir"/*; do
      if [[ -f "$item" && "$item" == "$dir"/abc* ]]; then
        # Delete the file starting with 'abc'
        echo "Deleting file: $item"
        rm "$item"
      elif [[ -d "$item" ]]; then
        # Recursively call the function for nested directories
        delete_files "$item"
      fi
    done
  fi
}

# Specify the root directory
# Demo-master
echo "Enter the file name to delete: "
read directory

mydi="C:/Users/Mayur/Desktop/MyProjects/$directory/app/src/main/res"
# Call the function to delete files starting with 'abc'
delete_files "$mydi"