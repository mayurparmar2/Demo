#!/bin/bash
ProjectName="TypingTest"
ANDROID_PROJECT_PATH="C:/AndroidProject/Test/$ProjectName"
JAVA_SRC_PATH="$ANDROID_PROJECT_PATH/app/src/main/java"
Jadx_RES_PATH="F:/SaveJadx/$ProjectName/resources/res"
RES_PATH="$ANDROID_PROJECT_PATH/app/src/main/res"
MAIN="$ANDROID_PROJECT_PATH/app/src/main"
directorieslist=(
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
    echo "File already exists.$(basename "$path")"
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
  echo "list_names : $resource_type => $search_path" >>xml.xml
  list_names=($(grep -Eo '@'$resource_type'/[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))

  if [ -n "${list_names[*]}" ]; then
    for resource_name in "${list_names[@]}"; do
      echo "fun_child resource_name :$resource_type / $resource_name"
      local path_list=$(find "$Jadx_RES_PATH" -name "$resource_name.*")
      for path in $path_list; do
        local directory=$(dirname "$path")
        local basename=$(basename "$directory")
        local bir_name=""
        IFS='-' read -ra parts <<<"$basename"
        if [ "${#parts[@]}" -gt 1 ]; then
          bir_name="${parts[0]}"
        fi
        if [[ $bir_name == *drawable* || $bir_name == *mipmap* ]]; then
          local destination_path="$RES_PATH/$basename"
          copyFile "$destination_path" "$path"
        else
          if [[ $basename != *-* ]]; then
            local destination_path="$RES_PATH/$basename"
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
  matches=null
  if [[ "$pattern" =~ "xml" ]]; then
    matches=($(grep -rEwo '@'$resource_type'/[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
  else
    matches=($(grep -rEwo '\bR\.'$resource_type'\.[A-Za-z0-9_]+\b' "$search_path" | awk -F'.' '{print $NF}'))
  fi
  if [ -n "${matches[*]}" ]; then
    for match in "${matches[@]}"; do
      echo "fun_main resource_name :$resource_type / $match"
      path_list=$(find "$Jadx_RES_PATH" -name "$match.*")
      for path in $path_list; do
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
#fun_main "java" "layout" $JAVA_SRC_PATH
for type_name in "${directorieslist[@]}"; do
  fun_main "java" "$type_name" "$JAVA_SRC_PATH"
done
for type_name in "${directorieslist[@]}"; do
  fun_main "xml" "$type_name" "$RES_PATH"
done

appIcon="C:/AndroidProject/GitHubDemo/app/src/main/res/drawable/icon200.png"
appIconDestinationDir="C:/AndroidProject/Test/$ProjectName/app/src/main/res/drawable"
if [ ! -d "$appIconDestinationDir" ]; then
  mkdir -p "$appIconDestinationDir"
fi
cp "$appIcon" "$appIconDestinationDir"



















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
