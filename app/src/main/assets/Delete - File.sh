#!/bin/bash

# StepCounter
# Function to recursively search and delete files starting with 'abc'
delete_files() {
  local dir="$1"
  
  # Check if the directory exists
  if [[ -d "$dir" ]]; then
    # Iterate through the contents of the directory
    for item in "$dir"/*; do
      if [[ -f "$item" && "$item" == "$dir"/abc_* 
          || "$item" == "$dir"/design_* 
          || "$item" == "$dir"/common_google*
          || "$item" == "$dir"/m3_*
          || "$item" == "$dir"/material_*
          || "$item" == "$dir"/mtrl_*
          || "$item" == "$dir"/test_*
          || "$item" == "$dir"/btn_*
          || "$item" == "$dir"/admob_*
          || "$item" == "$dir"/avd_*
          || "$item" == "$dir"/ic_m3_chip*
          || "$item" == "$dir"/res_*
          || "$item" == "$dir"/test_*
          || "$item" == "$dir"/notification_*
          || "$item" == "$dir"/custom_dialog*
          || "$item" == "$dir"/browser_*
          || "$item" == "$dir"/select_*
          || "$item" == "$dir"/text_view_*
          || "$item" == "$dir"/bools*
          || "$item" == "$dir"/integers*
          || "$item" == "$dir"/plurals*
          || "$item" == "$dir"/public*
          || "$item" == "$dir"/standalone_*
          || "$item" == "$dir"/splits0*
        ]]; then
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

mydi="C:/AndroidProject/$directory/app/src/main/res"
# Call the function to delete files starting with 'abc'
delete_files "$mydi"
