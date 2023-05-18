#!/bin/bash

# Prompt for user input
read -p "Enter the path of the directory containing the files: " directory

# Loop through all files in the directory
for file in "$directory"/*; do
  if [[ -f "$file" ]]; then
    # Execute the sed command on each file
    sed -i s/replacement/000000/g "$file"
  fi
done