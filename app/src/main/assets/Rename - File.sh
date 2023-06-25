#!/bin/bash
#echo "Enter the path of the ProjectName containing the files: "
#read ProjectName
ProjectName="Vimory_videoEditor_3_1"
#-----------------------Copy Project---------------------------
Project_java="C:/AndroidProject/$ProjectName/app/src/main/java"
Project_res="C:/AndroidProject/$ProjectName/app/src/main/res"
Project_main="C:/AndroidProject/$ProjectName/app/src/main"
Project_dir="C:/AndroidProject/$ProjectName"
source_dir="C:/AndroidProject/GithubDemo_empty"
jadx="F:/SaveJadx/$ProjectName"
jadx_assets="$jadx/resources/assets"
jadx_res="$jadx/resources/res"
jadx_res_values="$jadx/resources/res/values"

manifast="$jadx/resources/AndroidManifest.xml"
pakagename=$(grep -Eo 'package="[a-z0-9_\.]+' "$manifast" | awk -F'"' '{print $NF}')
PakageName_path="$(echo "$pakagename" | sed 's|\.|\/|g')"
sources="$jadx/sources/$PakageName_path"

value_exists() {
  local resource_type="$1"
  local search_value="$2"
  if grep -q 'name="'$search_value'"' ''$Project_res'/values/attrs.xml'; then
    return 0 # String found, return true
  else
    return 1 # String not found, return false
  fi
}
my_val_file=''$Project_res'/values/attrs.xml'
if [ ! -f "$my_val_file" ]; then
  touch "$my_val_file"
  echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<resources>\n</resources>" >"$my_val_file"
fi
matches=($(grep -rEwo '\bR\.styleable\.[A-Za-z0-9_]+\b' "$Project_java" | awk -F'.' '{print $NF}'))
if [ -n "${matches[*]}" ]; then
  for resource_name in "${matches[@]}"; do
    if ! value_exists "styleable" "$resource_name"; then
      result=$(grep -oP '(?<='$resource_name'\s=\s\{).*?(?=\})' "$sources/R.java")
      result=$(echo "$result" | tr -d '[:space:]' | tr ',' '\n')
      readarray -t values <<<"$result"
      attrFile=''$jadx_res_values'/attrs.xml'
      block+="<declare-styleable name=\"$resource_name\">"
      for attr in "${values[@]}"; do
        attrName=$(echo "$attr" | sed 's/R.attr.//')
        block+=$(cat "$jadx_res_values/attrs.xml" | grep -zPo "<attr name=\"$attrName\"[\s\S]*?</attr>")
        #                echo $(cat "$jadx_res_values/attrs.xml" | grep -zPo "<attr name=\"$attrName\"[\s\S]*?</attr>")
      done
      block+="</declare-styleable>"
      echo "$block"
      my_attr_file=''$Project_res'/values/attrs.xml'
      content=$(echo $block | sed 's/\//\\\//g')
      sed -i "/<\/resources>/ s/.*/${content}\n&/" "$my_attr_file"
    fi
  done
fi
