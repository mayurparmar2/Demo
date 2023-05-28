#!/bin/bash
ProjectName="Demo-master"
ANDROID_PROJECT_PATH="C:/AndroidProject/Test/$ProjectName"
JAVA_SRC_PATH="$ANDROID_PROJECT_PATH/app/src/main/java"
Jadx_RES_PATH="D:/SaveJadx/$ProjectName/resources/res"
RES_PATH="$ANDROID_PROJECT_PATH/app/src/main/res"
MAIN="$ANDROID_PROJECT_PATH/app/src/main"
directorieslist=(
    "C:/AndroidProject/Test/$ProjectName/app/src/main/res/layout"
  "C:/AndroidProject/Test/$ProjectName/app/src/main/res/drawable"
    "C:/AndroidProject/Test/$ProjectName/app/src/main/res/anim"
    "C:/AndroidProject/Test/$ProjectName/app/src/main/res/anim"
    "C:/AndroidProject/Test/$ProjectName/app/src/main/res/color"
    "C:/AndroidProject/Test/$ProjectName/app/src/main/res/font"
    "C:/AndroidProject/Test/$ProjectName/app/src/main/res/menu"
    "C:/AndroidProject/Test/$ProjectName/app/src/main/res/xml"
    "C:/AndroidProject/Test/$ProjectName/app/src/main/res/raw"
)

fun_main() {
   pattern="$1"



  echo "pattern :$pattern"

  for dir in "${directorieslist[@]}"; do
    resource_type="$(basename "$dir")"
    IFS='-' read -ra parts <<<"$resource_type"
    if [ "${#parts[@]}" -gt 1 ]; then
      resource_type="${parts[0]}"
    fi
    matches=null
    if [[ "$pattern" =~ "xml" ]]; then
      matches=($(grep -rEwo '@'$resource_type'/[A-Za-z0-9_]+' "$RES_PATH"))
    else
      matches=($(grep -rEwo '\bR\.'$resource_type'\.[A-Za-z0-9_]+\b' "$JAVA_SRC_PATH"))
    fi
    # Iterate over the array and extract the resource name using sed
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
        directory=$(dirname "$path")
        basename=$(basename "$directory")
        bir_name=""
        IFS='-' read -ra parts <<<"$basename"
        if [ "${#parts[@]}" -gt 1 ]; then
          bir_name="${parts[0]}"
        fi
        if [[ $bir_name == *drawable* || $bir_name == *mipmap* ]]; then
          destination_path="$RES_PATH/$basename"
          if [ ! -d "$destination_path" ]; then
            mkdir -p "$destination_path"
          fi
          cp "$path" "$destination_path"
        else
          if [[ $basename != *-* ]]; then
            destination_path="$RES_PATH/$basename"
            if [ ! -d "$destination_path" ]; then
              mkdir -p "$destination_path"
            fi
            cp "$path" "$destination_path"
          fi
        fi
      done
    done
  done

}
#fun_main "${directorieslist[@]}" "java"
fun_main "xml"
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
