#!/bin/bash
ProjectName="TypingTest"
ANDROID_PROJECT_PATH="C:/AndroidProject/Test/$ProjectName"
JAVA_SRC_PATH="$ANDROID_PROJECT_PATH/app/src/main/java"
Jadx_RES_PATH="F:/SaveJadx/TypingTest/resources/res/values"
RES_PATH="$ANDROID_PROJECT_PATH/app/src/main/res"
MAIN="$ANDROID_PROJECT_PATH/app/src/main"
value_list=(
  "array"
  "attr"
  "color"
  "dimen"
  "ref"
  "string"
  "style"
)
fun_main() {
  local resource_type="$1"
  local search_path="$2"
  my_val_file=''$RES_PATH'/values/'$resource_type's.xml'
  if [ ! -f "$my_val_file" ]; then
    touch "$my_val_file"
    echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<resources>\n</resources>" >"$my_val_file"
    echo "File created: $my_val_file"
  else
    echo "File already exists: $my_val_file"
  fi
  local matches=($(grep -rEwo '@'$resource_type'/[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
  if [ -n "${matches[*]}" ]; then
    echo "$matches"
    for resource_name in "${matches[@]}"; do
      block=""
      echo "resource_name $resource_name"
      jadx_val_file='F:/SaveJadx/TypingTest/resources/res/values/'$resource_type's.xml'
            case "$resource_type" in
            "style")
              block=$(cat "$jadx_val_file" | grep -zPo "<style name=\"$resource_name\"[\s\S]*?</style>")
              ;;
            *)
              block=$(cat "$jadx_val_file" | grep -oP "<$resource_type name=\"$resource_name\">.*?</$resource_type>")
              ;;
            esac
      C=$(echo $block | sed 's/\//\\\//g')
      sed -i "/<\/resources>/ s/.*/${C}\n&/" "$my_val_file"
    done
  fi
}
#fun_main "xml" "layout" $RES_PATH
for type_name in "${value_list[@]}"; do
  fun_main "$type_name" "$MAIN"
done







#style_j="F:/SaveJadx/TypingTest/resources/res/values/styles.xml"
#style_file="C:/AndroidProject/Test/TypingTest/app/src/main/res/values/styles.xml"
#style_block=$(cat "$style_j" | grep -zPo "<style name=\"ToolbarStyle\"[\s\S]*?</style>")
#
#C=$(echo $style_block | sed 's/\//\\\//g')
#sed -i "/<\/resources>/ s/.*/${C}\n&/" "$style_file"
#
#CONTENT="<student>\n<name>NewName</name>\n<id>NewID</id>\n</student>"
#
#C=$(echo "$style_block" | sed 's/\//\\\//g')
#sed -i "/<\/resources>/ s/.*/${C}\n&/" "$style_file"

#style_block=$(cat "$style_file" | grep -oP "<color name=\"colorAccent\">.*?</color>")
#style_file="C:/AndroidProject/Test/TypingTest/app/src/main/res/values/colors.xml"
#style_block=$(cat "$style_file" | grep -oP "<color name=\"colorAccent\">.*?</color>")
#style_block=$(cat "$style_file" | grep -zPo "<style name=\"AppTheme\"[\s\S]*?</style>")
#C=$(echo "$style_block" | sed 's/\//\\\//g')
#sed -i "/<\/resources>/ s/.*/${C}\n&/" "$style_file"
#
#if [ -n "$style_block" ]; then
#  echo "Style block found:"
#  echo "$style_block"
#else
#  echo "No style block found."
#fi

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
