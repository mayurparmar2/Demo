#!/bin/bash

# # Directory path containing files to rename
# directory="/path/to/directory"
#
# # Iterate through the files in the directory
# for file in "$directory"/*; do
#   if [[ -f "$file" ]]; then
#     # Extract the current file name and extension
#     filename=$(basename "$file")
#     extension="${filename##*.}"
#
#     # Generate the new file name
#     new_filename="new_file_name.${extension}"
#
#     # Rename the file
#     mv "$file" "$directory/$new_filename"
#     echo "Renamed file: $filename to $new_filename"
#   fi
# done


# Prepend a string to drawable names in Java files
Get-ChildItem -Recurse -Filter "*.java" | ForEach-Object {
  $content = Get-Content $_.FullName
  $newContent = $content -replace 'R\.drawable\.(\w+)(?=\W|$)', { R.drawable.new_$1 }
  $newContent | Set-Content $_.FullName
}


# "*.xml", "*.png"
$Report = Get-ChildItem | Where-Object { $_.Extension -eq '.png' -or $_.Extension -eq '.xml' } | ForEach-Object {
    $NewName = $_.Name -replace '^', 'new_'
    Rename-Item $_.FullName -NewName $NewName
    [PSCustomObject]@{
        OldName = $_.Name
        NewName = $NewName
    }
}
$Report | Format-Table -AutoSize | Out-File -FilePath ../../assets/report.txt

# "*.xml", "*.png"
$Report = Get-ChildItem | Where-Object { $_.Extension -eq '.png' -or $_.Extension -eq '.xml' } | ForEach-Object {
    $RandomString = [System.IO.Path]::GetRandomFileName().Replace('.', '')
    $NewName = "new_$RandomString$($_.Extension)"
    Rename-Item $_.FullName -NewName $NewName
    [PSCustomObject]@{
        OldName = $_.Name
        NewName = $NewName
    }
}
$Report | Format-Table -AutoSize | Out-File -FilePath ../../assets/report.txt

