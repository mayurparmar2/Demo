#!/bin/bash


file_list=()  # Initialize an empty array to store the file list

# Add files to the list
file1="/path/to/file1.txt"
file2="/path/to/file2.txt"
file2="/path/to/file2.txt"

# Check if file1 is not already in the list before adding it
if [[ ! " ${file_list[@]} " =~ " ${file1} " ]]; then
    file_list+=("$file1")
fi

# Check if file2 is not already in the list before adding it
if [[ ! " ${file_list[@]} " =~ " ${file2} " ]]; then
    file_list+=("$file2")
fi

# Print the file list
for file in "${file_list[@]}"; do
    echo "$file"
done
