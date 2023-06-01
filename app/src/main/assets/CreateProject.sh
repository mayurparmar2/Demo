#!/bin/bash
echo "Enter the path of the ProjectName containing the files: "
read ProjectName

#-----------------------Copy Project---------------------------
Project_java="C:/AndroidProject/$ProjectName/app/src/main/java"
Project_res="C:/AndroidProject/$ProjectName/app/src/main/res"
Project_main="C:/AndroidProject/$ProjectName/app/src/main"
Project_dir="C:/AndroidProject/$ProjectName"
source_dir="C:/AndroidProject/GithubDemo"
jadx="F:/SaveJadx/$ProjectName"
jadx_assets="$jadx/resources/assets"
jadx_res="$jadx/resources/res"
jadx_res_values="$jadx/resources/res/values"
if [ ! -d "$jadx" ]; then
  echo "$jadx was not found"
  return
fi
if [ ! -d "$source_dir" ]; then
  echo "$source_dir was not found"
  return
fi
if [ ! -d "$source_dir" ]; then
  echo "$source_dir was not found"
  return
fi
if [ ! -d "C:/AndroidProject" ]; then
  mkdir -p "C:/AndroidProject was not found"
fi
if [ ! -d "$Project_dir" ]; then
  mkdir -p "$Project_dir"
fi
cp -r "$source_dir"/* "$Project_dir"
#------------------------Create Link----------------------------
linkFile="$Project_dir/link.txt"
if [ ! -f "$linkFile" ]; then
  touch "$linkFile"
fi
manifast="$jadx/resources/AndroidManifest.xml"
pakagename=$(grep -Eo 'package="[a-z0-9_\.]+' "$manifast" | awk -F'"' '{print $NF}')
version=$(grep -Eo 'versionName="[a-z0-9_\.]+' "$manifast" | awk -F'"' '{print $NF}')
echo -e 'Link    : https://play.google.com/store/apps/details?id='$pakagename'\nPackage : '$pakagename' \nversion : '$version'' >"$linkFile"
#-----------------------Copy Package Path----------------------------
PakageName_path="$(echo "$pakagename" | sed 's|\.|\/|g')"
sources="$jadx/sources/$PakageName_path"
if [ ! -d "$Project_java/$PakageName_path" ]; then
  mkdir -p "$Project_java/$PakageName_path"
fi
cp -r "$sources"/* "$Project_java/$PakageName_path"
#-----------------------Copy Resources Path----------------------------

if [ -d "$Project_main"/jadx_assets ]; then
  rm -r "$Project_main"/jadx_assets
fi
#if [ -d "$Project_main"/jadx_res ]; then
#  rm -r "$Project_main"/jadx_res
#fi
cp -r "$jadx_assets" "$Project_main"
#cp -r "$jadx_res" "$Project_main"

#----------------------Delete R.java  and Config.java--------------------------
if [ -f "$Project_java/$PakageName_path/R.java" ]; then
  rm "$Project_java/$PakageName_path/R.java"
fi
if [ -f "$Project_java/$PakageName_path/BuildConfig.java" ]; then
  rm "$Project_java/$PakageName_path/BuildConfig.java"
fi
#-----------------------Find And Copy Resources From Java---------------------------

query_list='(?!.*'
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
  current_name_ext=$(basename "$path")
  file_name_without_extension="${current_name_ext%.*}"
  query_list+=''$file_name_without_extension'|.*'
  for type_name in "${directorieslist[@]}"; do
    fun_child "$type_name" "$path"
  done
}
fun_child() {
  local resource_type="$1"
  local search_path="$2"
  #  echo "list_names : $resource_type => $search_path" >>xml.xml
  local list_names=($(grep -Eo '@'$resource_type'/'$query_list'abc_btn_material)[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
  echo 'fun_child query_list : '$query_list'abc_btn_material)'
  if [ -n "${list_names[*]}" ]; then
    for resource_name in "${list_names[@]}"; do
      #      echo "fun_child resource_name :$resource_type / $resource_name"
      local path_list=$(find "$jadx_res" -name "$resource_name.*")
      for path in $path_list; do
        local directory=$(dirname "$path")
        local basename=$(basename "$directory")
        local bir_name=""
        IFS='-' read -ra parts <<<"$basename"
        if [ "${#parts[@]}" -gt 1 ]; then
          bir_name="${parts[0]}"
        fi
        if [[ $bir_name == *drawable* || $bir_name == *mipmap* ]]; then
          local destination_path="$Project_res/$basename"
          copyFile "$destination_path" "$path"
        else
          if [[ $basename != *-* ]]; then
            local destination_path="$Project_res/$basename"
            copyFile "$destination_path" "$path"
          fi
        fi
      done
    done
  fi
}
fun_main() {
  local pattern="$1"
  local resource_type="$2"
  local search_path="$3"
  local matches=null
  if [[ "$pattern" =~ "xml" ]]; then
    matches=($(grep -rEwo '@'$resource_type'/[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
  else
    matches=($(grep -rEwo '\bR\.'$resource_type'\.[A-Za-z0-9_]+\b' "$search_path" | awk -F'.' '{print $NF}'))
  fi
  if [ -n "${matches[*]}" ]; then
    for match in "${matches[@]}"; do
      #      echo "fun_main resource_name :$resource_type / $match"
      local path_list=$(find "$jadx_res" -name "$match.*")
      for path in $path_list; do
        local directory=$(dirname "$path")
        local basename=$(basename "$directory")
        local bir_name=""
        IFS='-' read -ra parts <<<"$basename"
        if [ "${#parts[@]}" -gt 1 ]; then
          bir_name="${parts[0]}"
        fi
        if [[ $bir_name == *drawable* || $bir_name == *mipmap* ]]; then
          local destination_path="$Project_res/$basename"
          copyFile "$destination_path" "$path"
        else
          if [[ $basename != *-* ]]; then
            local destination_path="$Project_res/$basename"
            copyFile "$destination_path" "$path"
          fi
        fi
      done
    done
  fi
}
total_files=$(echo "$directorieslist" | wc -l)
replace_files=0
percentage=0
for type_name in "${directorieslist[@]}"; do
  fun_main "java" "$type_name" "$Project_java"
  ((replace_files++))
  percentage=$((replace_files * 100 / total_files))
  echo "stage 1/4 : Progress: $percentage% ($replace_files/$total_files files)"
done
total_files=$(echo "$directorieslist" | wc -l)
replace_files=0
percentage=0
for type_name in "${directorieslist[@]}"; do
  fun_main "xml" "$type_name" "$Project_res"
  ((replace_files++))
  percentage=$((replace_files * 100 / total_files))
  echo "stage 2/4 : Progress: $percentage% ($replace_files/$total_files files)"
done

appIcon="C:/AndroidProject/GitHubDemo/app/src/main/res/drawable/icon200.png"
appIconDestinationDir="C:/AndroidProject/Test/$ProjectName/app/src/main/res/drawable"
if [ ! -d "$appIconDestinationDir" ]; then
  mkdir -p "$appIconDestinationDir"
fi
cp "$appIcon" "$appIconDestinationDir"

#-----------------------Find And Copy Values From Java---------------------------
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
  if grep -q 'name="'$search_value'"' ''$Project_res'/values/'$resource_type's.xml'; then
    return 0 # String found, return true
  else
    return 1 # String not found, return false
  fi
}
fun_value_main() {
  local pattern="$1"
  local resource_type="$2"
  local search_path="$3"
  my_val_file=''$Project_res'/values/'$resource_type's.xml'
  if [ ! -f "$my_val_file" ]; then
    if ! [[ "$resource_type" == "styleable" ]]; then
      touch "$my_val_file"
      echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<resources>\n</resources>" >"$my_val_file"
    fi
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
      local block=""
      #      echo "resource_name $resource_name"
      #      echo "resource_name $resource_name"
      #      echo "resource_type $resource_type"
      if ! value_exists "$resource_type" "$resource_name"; then
        #        echo "value_exists 0"
        jadx_val_file=''$jadx_res_values'/'$resource_type's.xml'
        case "$resource_type" in
        "style")
          block=$(cat "$jadx_val_file" | grep -zPo "<style name=\"$resource_name\"[\s\S]*?</style>")
          ;;
        "array")
          block=$(cat "$jadx_val_file" | grep -zPo "<array name=\"$resource_name\"[\s\S]*?</array>")
          ;;
        "styleable")
          local jadx_r_file="$sources/R.java"
          local result=$(grep -oP '(?<='$resource_name'\s=\s\{).*?(?=\})' "$jadx_r_file")
          local result=$(echo "$result" | tr -d '[:space:]' | tr ',' '\n')
          readarray -t values <<<"$result"
          local attrFile=''$jadx_res_values'/attrs.xml'
          block+="<declare-styleable name=\"$resource_name\">"
          for attr in "${values[@]}"; do
            attrName=$(echo "$attr" | sed 's/R.attr.//')
            block+=$(cat "$jadx_res_values/attrs.xml" | grep -zPo "<attr name=\"$attrName\"[\s\S]*?</attr>")
            #            echo $(cat "$jadx_res_values/attrs.xml" | grep -zPo "<attr name=\"$attrName\"[\s\S]*?</attr>")
          done
          block+="</declare-styleable>"
          #          echo "$block"
          ;;
        *)
          block=$(cat "$jadx_val_file" | grep -oP "<$resource_type name=\"$resource_name\">.*?</$resource_type>")
          ;;
        esac
        if [[ "$resource_type" =~ "styleable" ]]; then
          local my_attr_file=''$Project_res'/values/attrs.xml'
          local content=$(echo $block | sed 's/\//\\\//g')
          sed -i "/<\/resources>/ s/.*/${content}\n&/" "$my_attr_file"
        else
          local content=$(echo $block | sed 's/\//\\\//g')
          sed -i "/<\/resources>/ s/.*/${content}\n&/" "$my_val_file"
        fi
      fi
    done
  fi
}

total_files=$(echo "$value_list" | wc -l)
replace_files=0
percentage=0
#fun_value_main "xml" "layout" $Project_res
for type_name in "${value_list[@]}"; do
  fun_value_main "xml" "$type_name" "$Project_main"
  ((replace_files++))
  percentage=$((replace_files * 100 / total_files))
  echo "stage 3/4 : Progress: $percentage% ($replace_files/$total_files files)"
done

total_files=$(echo "$value_list" | wc -l)
replace_files=0
percentage=0
for type_name in "${value_list[@]}"; do
  fun_value_main "java" "$type_name" "$Project_java"
  ((replace_files++))
  percentage=$((replace_files * 100 / total_files))
  echo "stage 3/4 : Progress: $percentage% ($replace_files/$total_files files)"
done
