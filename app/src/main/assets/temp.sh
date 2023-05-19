#!/bin/bash
# StepConter


echo "Enter the path of the directory containing the files: "
read ProjectName

sourceFile="C:/AndroidProject/GitHubDemo/app/src/main/res/drawable/icon200.png"
destinationDir="C:/AndroidProject/$ProjectName/app/src/main/res/drawable"

# Copy the file
cp "$sourceFile" "$destinationDir"
echo "File copied successfully."





# Get-ChildItem -Recurse -Filter "*.xml" | ForEach-Object {
#   $content = Get-Content $_.FullName
#   $newContent1 = $content -replace '<(\w+)\s+[^>]*name="common_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent2 = $newContent1 -replace '<(\w+)\s+[^>]*name="m3_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent3 = $newContent2 -replace '<(\w+)\s+[^>]*name="bright_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent4 = $newContent3 -replace '<(\w+)\s+[^>]*name="cardview_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent5 = $newContent4 -replace '<(\w+)\s+[^>]*name="design_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent6 = $newContent5 -replace '<(\w+)\s+[^>]*name="dim_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent7 = $newContent6 -replace '<(\w+)\s+[^>]*name="foreground_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent8 = $newContent7 -replace '<(\w+)\s+[^>]*name="error_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent9 = $newContent8 -replace '<(\w+)\s+[^>]*name="mtrl_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent10 = $newContent9 -replace '<(\w+)\s+[^>]*name="primary_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent11 = $newContent10 -replace '<(\w+)\s+[^>]*name="ripple_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent12 = $newContent11 -replace '<(\w+)\s+[^>]*name="secondary_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent13 = $newContent12 -replace '<(\w+)\s+[^>]*name="tooltip_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent14 = $newContent13 -replace '<(\w+)\s+[^>]*name="switch_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent15 = $newContent14 -replace '<(\w+)\s+[^>]*name="foreground_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent16 = $newContent16 -replace '<(\w+)\s+[^>]*name="material_[^"]*"[^>]*>(.*?)<\/\1>', {  }
#   $newContent16 | Set-Content $_.FullName
# }







