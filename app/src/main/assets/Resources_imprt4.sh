#!/bin/bash
ProjectName="RecoverDeletedFiles"
ANDROID_PROJECT_PATH="C:/AndroidProject/$ProjectName"
JAVA_SRC_PATH="$ANDROID_PROJECT_PATH/app/src/main/java"
Jadx_RES_PATH="F:/SaveJadx/$ProjectName/resources/res/values"
Jadx_r_PATH="F:/SaveJadx/$ProjectName/sources/recover/deleted/all/files/photo/video/appcompany"
RES_PATH="$ANDROID_PROJECT_PATH/app/src/main/res"
MAIN="$ANDROID_PROJECT_PATH/app/src/main"

if [ -f "$Jadx_r_PATH/R.java" ]; then
  rm "$Jadx_r_PATH/R.java"
fi
if [ -f "$Jadx_r_PATH/BuildConfig.java" ]; then
  rm "$Jadx_r_PATH/BuildConfig.java"
fi

value_list=(
  "array"
  "attr"
  "color"
  "dimen"
  "ref"
  "string"
  "style"
  "styleable"
)
value_exists() {
  local resource_type="$1"
  local search_value="$2"
  if grep -q 'name="'$search_value'"' ''$RES_PATH'/values/'$resource_type's.xml'; then
    return 0 # String found, return true
  else
    return 1 # String not found, return false
  fi
}
fun_value_main() {
  local pattern="$1"
  local resource_type="$2"
  local search_path="$3"
  my_val_file=''$RES_PATH'/values/'$resource_type's.xml'
  if [ ! -f "$my_val_file" ]; then
    if [[ "$resource_type" =~ "styleable" ]]; then
      return
    fi
    touch "$my_val_file"
    echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<resources>\n</resources>" >"$my_val_file"
  fi
  local matches=null
  if [[ "$pattern" =~ "xml" ]]; then
    matches=($(grep -rEwo '@'$resource_type'/(?!.*sdp|.*ssp)[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
  else
    matches=($(grep -rEwo '\bR\.'$resource_type'\.[A-Za-z0-9_]+\b' "$search_path" | awk -F'.' '{print $NF}'))
  fi
  if [ -n "${matches[*]}" ]; then
    echo "$matches"
    for resource_name in "${matches[@]}"; do
      block=""
      #      echo "resource_name $resource_name"
      echo "resource_name $resource_name"
      echo "resource_type $resource_type"
      if ! value_exists "$resource_type" "$resource_name"; then
        echo "value_exists 0"
        jadx_val_file=''$Jadx_RES_PATH'/'$resource_type's.xml'
        case "$resource_type" in
        "style")
          block=$(cat "$jadx_val_file" | grep -zPo "<style name=\"$resource_name\"[\s\S]*?</style>")
          ;;
        "styleable")
          # Use grep with a regular expression to extract the values inside the brackets
          result=$(grep -oP '(?<='$resource_name'\s=\s\{).*?(?=\})' "$Jadx_r_PATH/R.java")
          result=$(echo "$result" | tr -d '[:space:]' | tr ',' '\n')
          readarray -t values <<<"$result"
          attrFile=''$Jadx_RES_PATH'/attrs.xml'
          block+="<declare-styleable name=\"$resource_name\">"
          for attr in "${values[@]}"; do
            attrName=$(echo "$attr" | sed 's/R.attr.//')
            block+=$(cat "$Jadx_RES_PATH/attrs.xml" | grep -zPo "<attr name=\"$attrName\"[\s\S]*?</attr>")
            echo $(cat "$Jadx_RES_PATH/attrs.xml" | grep -zPo "<attr name=\"$attrName\"[\s\S]*?</attr>")
          done
          block+="</declare-styleable>"
          echo "$block"
          ;;
        *)
          block=$(cat "$jadx_val_file" | grep -oP "<$resource_type name=\"$resource_name\">.*?</$resource_type>")
          ;;
        esac
        if [[ "$resource_type" =~ "styleable" ]]; then
          my_attr_file=''$RES_PATH'/values/attrs.xml'
          content=$(echo $block | sed 's/\//\\\//g')
          sed -i "/<\/resources>/ s/.*/${content}\n&/" "$my_attr_file"
        else
          content=$(echo $block | sed 's/\//\\\//g')
          sed -i "/<\/resources>/ s/.*/${content}\n&/" "$my_val_file"
        fi
      fi
    done
  fi
}
#fun_value_main "xml" "layout" $RES_PATH
for type_name in "${value_list[@]}"; do
  fun_value_main "xml" "$type_name" "$MAIN"
done
for type_name in "${value_list[@]}"; do
  fun_value_main "java" "$type_name" "$JAVA_SRC_PATH"
done



#block=$(echo '<attr name="1000">128.00dp</attr>' | grep -zP "<attr name=\"(?!1000sdp|1000mdp)[^\"]*1000[^\"]*\"[\s\S]*?</attr>")
#echo "$block"
#
#resource_name="_80sdp"
#block=$(echo '<attr name="1000">128.00dp</attr>' | grep -zP "<attr name=\"(?!sdp|mdp)[^\"]*1000[^\"]*\"[\s\S]*?</attr>")
#echo "$block"
#
#(?!sdp|mdp)
#matches=($(grep -rEwo '@'$resource_type'/[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
#matches=($(grep -rEwo '@dimen/(?!sdp|mdp)[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
#string="1000sdp"
#
#if echo "$string" | grep -q "sdp"; then
#  echo "String contains 'sdp'"
#else
#  echo "String does not contain 'sdp'"
#fi
#
#string="1000sdptest"
#
#if ! echo "$string" | grep -qE "sdp|mdp"; then
#fi
#
#
##!/bin/bash
#
#string="1000test"
#
#if ! echo "$string" | grep -qE "sdp|mdp"; then
#  echo "String does not contain 'sdp' or 'mdp'"
#else
#  echo "String contains 'sdp' or 'mdp'"
#fi
#

#fun_value_main "java" "styleable" "$JAVA_SRC_PATH"

#directory="F:/SaveJadx/WeightLossCalculator/sources/com/despdev/weight_loss_calculator/R.java"
#!/bin/bash

# XML data

## Use grep with a regular expression to extract the values inside the brackets
#result=$(grep -oP '(?<=ActionBar\s=\s\{).*?(?=\})' "$directory")
#result=$(echo "$result" | tr -d '[:space:]' | tr ',' '\n')
#readarray -t values <<<"$result"
#for value in "${values[@]}"; do
#  echo "$value"
#done

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
