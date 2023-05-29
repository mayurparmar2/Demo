#!/bin/bash
ProjectName="TypingTest"
ANDROID_PROJECT_PATH="C:/AndroidProject/Test/$ProjectName"
JAVA_SRC_PATH="$ANDROID_PROJECT_PATH/app/src/main/java"
Jadx_RES_PATH="F:/SaveJadx/$ProjectName/resources/res"
RES_PATH="$ANDROID_PROJECT_PATH/app/src/main/res"
MAIN="$ANDROID_PROJECT_PATH/app/src/main"

## Copy the file
#appIcon="C:/AndroidProject/GitHubDemo/app/src/main/res/drawable/icon200.png"
#appIconDestinationDir="C:/AndroidProject/Test/$ProjectName/app/src/main/res/drawable"
#if [ ! -d "$appIconDestinationDir" ]; then
#  mkdir -p "$appIconDestinationDir"
#fi
#cp "$appIcon" "$appIconDestinationDir"

directorieslist=(
  "values"
  "layout"
  "drawable"
  "anim"
  "anim"
  "color"
  "font"
  "menu"
  "xml"
  "raw"
)
copyFile() {
  local destination_path="$1"
  local path="$2"
    if [[ -e "$destination_path/$(basename "$path")" ]]; then
      echo "File already exists. Skipping copy operation."
      return
    fi
  if [ ! -d "$destination_path" ]; then
    mkdir -p "$destination_path"
  fi
  cp "$path" "$destination_path"
  for type_name in "${directorieslist[@]}"; do
    fun_child "$type_name" "$path"
  done
}
fun_child() {
  resource_type="$1"
  search_path="$2"
  #  matches=($(grep -Eo '@'$resource_type'/[A-Za-z0-9_]+' "$search_path"))
  list_names=($(grep -Eo '@'$resource_type'/[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
  if [ -n "${list_names[*]}" ]; then
    for resource_name in "${list_names[@]}"; do
      #      resource_name=$(echo "$match" | sed -E 's/@'$resource_type'\/([A-Za-z0-9_]+)/\1/')
      #      resource_name=$(echo "$resource_name" | awk -F'/' '{print $NF}')
      path_list=$(find "$Jadx_RES_PATH" -name "$resource_name.*")
      for path in $path_list; do
        echo "path =>$path" >>path.xml
        directory=$(dirname "$path")
        basename=$(basename "$directory")
        bir_name=""
        IFS='-' read -ra parts <<<"$basename"
        if [ "${#parts[@]}" -gt 1 ]; then
          bir_name="${parts[0]}"
        fi
        if [[ $bir_name == *drawable* || $bir_name == *mipmap* ]]; then
          destination_path="$RES_PATH/$basename"
          copyFile "$destination_path" "$path"
        else
          if [[ $basename != *-* ]]; then
            destination_path="$RES_PATH/$basename"
            copyFile "$destination_path" "$path"
          fi
        fi
      done
    done
  fi
}
fun_main() {
  pattern="$1"
  resource_type="$2"
  search_path="$3"
  echo "pattern :$1"
  matches=null
  if [[ "$pattern" =~ "xml" ]]; then
    matches=($(grep -rEwo '@'$resource_type'/[A-Za-z0-9_]+' "$search_path"))
  else
    matches=($(grep -rEwo '\bR\.'$resource_type'\.[A-Za-z0-9_]+\b' "$search_path"))
  fi
  if [ -n "${matches[*]}" ]; then
    for match in "${matches[@]}"; do
      resource_name=""
      if [[ "$pattern" =~ "xml" ]]; then
        resource_name=$(echo "$match" | sed -E 's/@'$resource_type'\/([A-Za-z0-9_]+)/\1/')
        resource_name=$(echo "$resource_name" | awk -F':' '{print $NF}')
      else
        resource_name=$(echo "$match" | awk -F'.' '{print $NF}')
      fi
      echo "$resource_name"
      path_list=$(find "$Jadx_RES_PATH" -name "$resource_name.*")
      for path in $path_list; do
        echo "path =>$path" >>path.xml
        directory=$(dirname "$path")
        basename=$(basename "$directory")
        bir_name=""
        IFS='-' read -ra parts <<<"$basename"
        if [ "${#parts[@]}" -gt 1 ]; then
          bir_name="${parts[0]}"
        fi
        if [[ $bir_name == *drawable* || $bir_name == *mipmap* ]]; then
          destination_path="$RES_PATH/$basename"
          copyFile "$destination_path" "$path"
        else
          if [[ $basename != *-* ]]; then
            destination_path="$RES_PATH/$basename"
            copyFile "$destination_path" "$path"
          fi
        fi
      done
    done
  fi
}
#fun_main "xml" "layout" $RES_PATH
for type_name in "${directorieslist[@]}"; do
  fun_main "java" "$type_name" $JAVA_SRC_PATH
done
#fun_main "java" "layout" $JAVA_SRC_PATH


#styles_xml_file="C:/AndroidProject/Test/TypingTest/app/src/main/res/layout/activity_main.xml"
#resource_names_styles=($(grep -Eo '@font/[A-Za-z0-9_]+' "$styles_xml_file" | awk -F'/' '{print $NF}'))
## Iterate over resource names in styles.xml
#for resource_name in "${resource_names_styles[@]}"; do
#  echo "$resource_name"
#done
#xml_directory="C:/AndroidProject/Test/TypingTest/app/src/main/res"
#resource_names_xml=($(find "$xml_directory" -type f -name "*.xml" -exec grep -Eo '@font/[A-Za-z0-9_]+' {} \; | awk -F'/' '{print $NF}'))
## Iterate over resource names in XML files
#for resource_name in "${resource_names_xml[@]}"; do
#  echo "$resource_name"
#done

#-------------------------------------------------------------------
#ProjectName="Demo-master"
#ANDROID_PROJECT_PATH="C:/AndroidProject/Test/$ProjectName"
#JAVA_SRC_PATH="$ANDROID_PROJECT_PATH/app/src/main/java"
#Jadx_RES_PATH="D:/SaveJadx/$ProjectName/resources/res"
#RES_PATH="$ANDROID_PROJECT_PATH/app/src/main/res"
#MAIN="$ANDROID_PROJECT_PATH/app/src/main"
#directorieslist=(
#  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/layout"
#  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/drawable"
#  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/anim"
#  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/anim"
#  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/color"
#  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/font"
#  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/menu"
#  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/xml"
#  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/raw"
#)
#
#for dir in "${directorieslist[@]}"; do
#  resource_type="$(basename "$dir")"
#  IFS='-' read -ra parts <<<"$resource_type"
#  if [ "${#parts[@]}" -gt 1 ]; then
#    resource_type="${parts[0]}"
#  fi
#  matches=($(grep -rEwo '\bR\.'$resource_type'\.[A-Za-z0-9_]+\b' "$JAVA_SRC_PATH"))
#  for match in "${matches[@]}"; do
#    resource_name=$(echo "$match" | awk -F'.' '{print $NF}')
#    path_list=$(find "$Jadx_RES_PATH" -name "$resource_name.*")
#    echo "Matching files:"
#    for path in $path_list; do
#      directory=$(dirname "$path")
#      basename=$(basename "$directory")
#      bir_name=""
#      IFS='-' read -ra parts <<<"$basename"
#      if [ "${#parts[@]}" -gt 1 ]; then
#        bir_name="${parts[0]}"
#      fi
#      if [[ $bir_name == *drawable* || $bir_name == *mipmap* ]]; then
#        destination_path="$RES_PATH/$basename"
#        if [ ! -d "$destination_path" ]; then
#          mkdir -p "$destination_path"
#        fi
#        cp "$path" "$destination_path"
#      else
#        if [[ $basename != *-* ]]; then
#          destination_path="$RES_PATH/$basename"
#          if [ ! -d "$destination_path" ]; then
#            mkdir -p "$destination_path"
#          fi
#          cp "$path" "$destination_path"
#        fi
#      fi
#    done
#  done
#done

#-------------------------------------------------------------------
