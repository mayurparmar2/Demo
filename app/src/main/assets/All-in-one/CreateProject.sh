#!/bin/bash
#echo "Enter the path of the ProjectName containing the files: "
#read ProjectName

ProjectName="Campass"

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

if [ -d "$Project_main/$jadx_assets" ]; then
  rm -r "$Project_main/$jadx_assets"
fi
if [ -d "$Project_main/$jadx_res" ]; then
  rm -r "$Project_main/$jadx_res"
fi
cp -r "$jadx_assets" "$Project_main"
#cp -r "$jadx_res" "$Project_main"
rm -rf "$Project_res/values"/*
#----------------------Delete R.java  and Config.java--------------------------
if [ -f "$Project_java/$PakageName_path/R.java" ]; then
  rm "$Project_java/$PakageName_path/R.java"
fi
if [ -f "$Project_java/$PakageName_path/BuildConfig.java" ]; then
  rm "$Project_java/$PakageName_path/BuildConfig.java"
fi

#-----------------------Find And Copy Resources From Java---------------------------

#query_list='(?!.*'
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
  #  current_name_ext=$(basename "$path")
  #  file_name_without_extension="${current_name_ext%.*}"
  #  query_list+=''$file_name_without_extension'|.*'
  for type_name in "${directorieslist[@]}"; do
    fun_child "$type_name" "$path"
  done
}
fun_child() {
  local resource_type="$1"
  local search_path="$2"
  #  echo "list_names : $resource_type => $search_path" >>xml.xml
  #  local list_names=($(grep -Eo '@'$resource_type'/'$query_list'abc_btn_material)[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
  local list_names=($(grep -Eo '@'$resource_type'/[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
  #  echo 'fun_child query_list : '$query_list'abc_btn_material)'
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
total_files=$(echo "${directorieslist[@]}" | wc -w)
replace_files=0
percentage=0
for type_name in "${directorieslist[@]}"; do
  fun_main "java" "$type_name" "$Project_java"
  ((replace_files++))
  percentage=$((replace_files * 100 / total_files))
  echo "stage 1/4 : Progress: $percentage% ($replace_files/$total_files files)"
done
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
#value_list=(
#  "array"
#  "attr"
#  "color"
#  "dimen"
#  "ref"
#  "string"
#  "style"
#  "styleable"
#)
#value_exists() {
#  local resource_type="$1"
#  local search_value="$2"
#  if grep -q 'name="'$search_value'"' ''$Project_res'/values/'$resource_type's.xml'; then
#    return 0 # String found, return true
#  else
#    return 1 # String not found, return false
#  fi
#}
#fun_value_main() {
#  local pattern="$1"
#  local resource_type="$2"
#  local search_path="$3"
#  my_val_file=''$Project_res'/values/'$resource_type's.xml'
#  if [ ! -f "$my_val_file" ]; then
#    if ! [[ "$resource_type" == "styleable" ]]; then
#      touch "$my_val_file"
#    fi
#  fi
#  echo -e "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<resources>\n</resources>" >"$my_val_file"
#  local matches=null
#  if [[ "$pattern" =~ "xml" ]]; then
#    #    matches=($(grep -rEwo '@'$resource_type'/(?!.*sdp|.*ssp)[A-Za-z0-9_]+' "$search_path" | awk -F'/' '{print $NF}'))
#    matches=($(grep -rEwo "@$resource_type\/[A-Za-z0-9_]+" "$search_path" | awk -F'/' '{print $NF}'))
#  else
#    matches=($(grep -rEwo '\bR\.'$resource_type'\.[A-Za-z0-9_]+\b' "$search_path" | awk -F'.' '{print $NF}'))
#  fi
#  if [ -n "${matches[*]}" ]; then
#    echo "$matches"
#    for resource_name in "${matches[@]}"; do
#      local block=""
#      echo "Values ===========> $resource_type / $resource_name"
#      if ! value_exists "$resource_type" "$resource_name"; then
#        #        echo "value_exists 0"
#        jadx_val_file=''$jadx_res_values'/'$resource_type's.xml'
#        case "$resource_type" in
#        "style")
#          block=$(grep -zPo "<style name=\"$resource_name\"[\s\S]*?</style>" "$jadx_val_file")
#          ;;
#        "array")
#          block=$(grep -zPo "<array name=\"$resource_name\"[\s\S]*?</array>" "$jadx_val_file")
#          ;;
#        "styleable")
#          local jadx_r_file="$sources/R.java"
#          local result=$(grep -oP '(?<='$resource_name'\s=\s\{).*?(?=\})' "$jadx_r_file")
#          local result=$(echo "$result" | tr -d '[:space:]' | tr ',' '\n')
#          readarray -t values <<<"$result"
#          local attrFile=''$jadx_res_values'/attrs.xml'
#          block+="<declare-styleable name=\"$resource_name\">"
#          for attr in "${values[@]}"; do
#            attrName=$(echo "$attr" | sed 's/R.attr.//')
#            block+=$(cat "$jadx_res_values/attrs.xml" | grep -zPo "<attr name=\"$attrName\"[\s\S]*?</attr>")
#            #            echo $(cat "$jadx_res_values/attrs.xml" | grep -zPo "<attr name=\"$attrName\"[\s\S]*?</attr>")
#          done
#          block+="</declare-styleable>"
#          #          echo "$block"
#          ;;
#        *)
#          block=$(grep -oP "<$resource_type name=\"$resource_name\">.*?</$resource_type>" "$jadx_val_file")
#          ;;
#        esac
#        if [[ "$resource_type" =~ "styleable" ]]; then
#          local my_attr_file=''$Project_res'/values/attrs.xml'
#          local content=$(echo $block | sed 's/\//\\\//g')
#          sed -i "/<\/resources>/ s/.*/${content}\n&/" "$my_attr_file"
#        else
#          local content=$(echo $block | sed 's/\//\\\//g')
#          sed -i "/<\/resources>/ s/.*/${content}\n&/" "$my_val_file"
#        fi
#      fi
#    done
#  fi
#}
#total_files=$(echo "${value_list[@]}" | wc -w)
#replace_files=0
#percentage=0
##fun_value_main "xml" "layout" $Project_res
#for type_name in "${value_list[@]}"; do
#  fun_value_main "xml" "$type_name" "$Project_main"
#  ((replace_files++))
#  percentage=$((replace_files * 100 / total_files))
#  echo "stage 3/4 : Progress: $percentage% ($replace_files/$total_files files)"
#done
#
#replace_files=0
#percentage=0
#for type_name in "${value_list[@]}"; do
#  fun_value_main "java" "$type_name" "$Project_java"
#  ((replace_files++))
#  percentage=$((replace_files * 100 / total_files))
#  echo "stage 3/4 : Progress: $percentage% ($replace_files/$total_files files)"
#done
#
#replace_files=0
#percentage=0
#for type_name in "${value_list[@]}"; do
#  fun_value_main "xml" "$type_name" "$Project_main"
#  ((replace_files++))
#  percentage=$((replace_files * 100 / total_files))
#  echo "stage 3/4 : Progress: $percentage% ($replace_files/$total_files files)"
#done

#--------------------- Replace java content -------------------------

java_files=$(find "$Project_java/$PakageName_path" -type f -name '*.java')
total_files=$(echo "$java_files" | wc -l)
replace_files=0
percentage=0
for file in $java_files; do
  sed -i "s/import $pakagename.R;/import com.demo.example.R;/g" "$file"
  sed -i "s/e = e.*?;//g" "$file"
  sed -i "s/import com\.android\.billingclient[^;]*;//g" "$file"
  sed -i "s/import com\.google\.common[^;]*;//g" "$file"
  sed -i "s/import com\.google\.firebase[^;]*;//g" "$file"
  sed -i "s/import com\.google\.ads[^;]*;//g" "$file"
  sed -i "s/import com\.google\.android\.gms\.common[^;]*;//g" "$file"
  sed -i "s/import com\.google\.android\.gms\.ads[^;]*;//g" "$file"
  sed -i "s/import com\.google\.android\.ads[^;]*;//g" "$file"
  sed -i "s/import androidx\.constraintlayout[^;]*;//g" "$file"
  sed -i "s/import androidx\.lifecycle\.ProcessLifecycleOwner[^;]*;//g" "$file"
  sed -i "s/import androidx\.multidex[^;]*;//g" "$file"
  sed -i "s/import kotlinx\.coroutines[^;]*;//g" "$file"
  sed -i 's/1)\.show();/Toast\.LENGTH_LONG)\.show();/g' "$file"
  sed -i 's/0)\.show();/Toast\.LENGTH_SHORT)\.show();/g' "$file"
  sed -i 's/getVisibility() != 0/getVisibility() != View.VISIBLE/g' "$file"
  sed -i 's/setScrollBarStyle(33554432)/setScrollBarStyle(View.SCROLLBARS_OUTSIDE_OVERLAY)/g' "$file"
  sed -i 's/? 8 : 0/? View.GONE : View.VISIBLE/g' "$file"
  sed -i 's/0).show();/Toast.LENGTH_SHORT).show();/g' "$file"
  sed -i 's/1).show();/Toast.LENGTH_LONG).show();/g' "$file"
  sed -i 's/getVisibility() != 0/getVisibility() != View.VISIBLE/g' "$file"
  sed -i 's/setScrollBarStyle(33554432)/setScrollBarStyle(View.SCROLLBARS_OUTSIDE_OVERLAY)/g' "$file"
  sed -i 's/? 8 : 0/? View.GONE : View.VISIBLE/g' "$file"
  sed -i 's/setVisibility(0)/setVisibility(View.VISIBLE)/g' "$file"
  sed -i 's/setVisibility(4)/setVisibility(View.INVISIBLE)/g' "$file"
  sed -i 's/setVisibility(8)/setVisibility(View.GONE)/g' "$file"
  sed -i 's/getSystemService("power")/getSystemService(Context.POWER_SERVICE)/g' "$file"
  sed -i 's/getSystemService("connectivity")/getSystemService(Context.CONNECTIVITY_SERVICE)/g' "$file"
  sed -i 's/getSystemService("powerstats")/getSystemService(Context.POWER_STATS_SERVICE)/g' "$file"
  sed -i 's/getSystemService("recovery")/getSystemService(Context.RECOVERY_SERVICE)/g' "$file"
  sed -i 's/getSystemService("system_update")/getSystemService(Context.SYSTEM_UPDATE_SERVICE)/g' "$file"
  sed -i 's/getSystemService("window")/getSystemService(Context.WINDOW_SERVICE)/g' "$file"
  sed -i 's/getSystemService("layout_inflater")/getSystemService(Context.LAYOUT_INFLATER_SERVICE)/g' "$file"
  sed -i 's/getSystemService("account")/getSystemService(Context.ACCOUNT_SERVICE)/g' "$file"
  sed -i 's/getSystemService("activity")/getSystemService(Context.ACTIVITY_SERVICE)/g' "$file"
  sed -i 's/getSystemService("alarm")/getSystemService(Context.ALARM_SERVICE)/g' "$file"
  sed -i 's/getSystemService("notification")/getSystemService(Context.NOTIFICATION_SERVICE)/g' "$file"
  sed -i 's/getSystemService("accessibility")/getSystemService(Context.ACCESSIBILITY_SERVICE)/g' "$file"
  sed -i 's/getSystemService("keyguard")/getSystemService(Context.KEYGUARD_SERVICE)/g' "$file"
  sed -i 's/getSystemService("search")/getSystemService(Context.SEARCH_SERVICE)/g' "$file"
  sed -i 's/getSystemService("storagestats")/getSystemService(Context.STORAGE_STATS_SERVICE)/g' "$file"
  sed -i 's/getSystemService("vibrator")/getSystemService(Context.VIBRATOR_SERVICE)/g' "$file"
  sed -i 's/getSystemService("connectivity")/getSystemService(Context.CONNECTIVITY_SERVICE)/g' "$file"
  sed -i 's/getSystemService("network_stack")/getSystemService(Context.NETWORK_STACK_SERVICE)/g' "$file"
  sed -i 's/getSystemService("tethering")/getSystemService(Context.TETHERING_SERVICE)/g' "$file"
  sed -i 's/getSystemService("test_network")/getSystemService(Context.TEST_NETWORK_SERVICE)/g' "$file"
  sed -i 's/getSystemService("wifi")/getSystemService(Context.WIFI_SERVICE)/g' "$file"
  sed -i 's/getSystemService("wifiscanner")/getSystemService(Context.WIFI_SCANNING_SERVICE)/g' "$file"
  sed -i 's/getSystemService("audio")/getSystemService(Context.AUDIO_SERVICE)/g' "$file"
  sed -i 's/getSystemService("auth")/getSystemService(Context.AUTH_SERVICE)/g' "$file"
  sed -i 's/getSystemService("fingerprint")/getSystemService(Context.FINGERPRINT_SERVICE)/g' "$file"
  sed -i 's/getSystemService("input_method")/getSystemService(Context.INPUT_METHOD_SERVICE)/g' "$file"
  sed -i 's/getSystemService("bluetooth")/getSystemService(Context.BLUETOOTH_SERVICE)/g' "$file"
  sed -i 's/getSystemService("permission")/getSystemService(Context.PERMISSION_SERVICE)/g' "$file"
  sed -i 's/getSystemService("camera")/getSystemService(Context.CAMERA_SERVICE)/g' "$file"
  sed -i 's/getSystemService("sensor")/getSystemService(Context.SENSOR_SERVICE)/g' "$file"
  sed -i 's/getSystemService("connectivity")/getSystemService(Context.CONNECTIVITY_SERVICE)/g' "$file"
  sed -i 's/getSystemService("location")/getSystemService(Context.LOCATION_SERVICE)/g' "$file"
  sed -i 's/getSystemService("clipboard")/getSystemService(Context.CLIPBOARD_SERVICE)/g' "$file"
  sed -i 's/getSystemService("storage")/getSystemService(Context.STORAGE_SERVICE)/g' "$file"
  sed -i 's/67108864/Intent.FLAG_ACTIVITY_CLEAR_TOP/g' "$file"
  sed -i 's/268435456/Intent.FLAG_ACTIVITY_NEW_TASK/g' "$file"
  sed -i 's/134217728/PendingIntent.FLAG_UPDATE_CURRENT/g' "$file"
  sed -i 's/33554432/PendingIntent.FLAG_MUTABLE/g' "$file"
  sed -i 's/addFlags(1)/addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)/g' "$file"
  sed -i 's/addFlags(2)/addFlags(Intent.FLAG_GRANT_WRITE_URI_PERMISSION)/g' "$file"
  sed -i 's/addFlags(64)/addFlags(Intent.FLAG_GRANT_PERSISTABLE_URI_PERMISSION)/g' "$file"
  sed -i 's/NotificationCompat\.CATEGORY_ALARM/Context\.ALARM_SERVICE/g' "$file"
  sed -i 's/SupportMenu.CATEGORY_MASK/0xffff0000/g' "$file"
  sed -i 's/import androidx.exifinterface.media.ExifInterface;/import android.media.ExifInterface;/g' "$file"
  class_name=$(grep -m 1 "class " "$file" | sed -n 's/.*class \([^ ]*\).*/\1/p')
  holdername=$(cat "$file" | grep -o -P "(?<=extends\sRecyclerView.Adapter<)\w+(?=>)")
  #  echo "Class holdername: $holdername"
  # Check if the class name is found
  if [[ -n $class_name && $holdername ]]; then
    sed -i "s/extends RecyclerView.Adapter<$holdername>/extends RecyclerView.Adapter<$class_name.$holdername>/g" "$file"
  fi
  #----------------------notification_channel--------------------------
  notification_channel=$(cat "$file" | grep -o -P "new NotificationChannel\(([^)]+)\)")
  regex="new NotificationChannel\(([^,]+),\s*([^,]+),\s*([^)]+)\)"
  if [[ $notification_channel =~ $regex ]]; then
    parameter1=${BASH_REMATCH[1]}
    parameter2=${BASH_REMATCH[2]}
    parameter3=${BASH_REMATCH[3]}
    parameter1=${parameter1//[[:space:]]/}
    parameter2=${parameter2//[[:space:]]/}
    parameter3=${parameter3//[[:space:]]/}
    #  sed -i "s/new NotificationChannel($parameter1, $parameter2, 2)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_LOW)/g" "$java_file_path"
    sed -i "s/new NotificationChannel($parameter1, $parameter2, 1)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_MIN)/g" "$file"
    sed -i "s/new NotificationChannel($parameter1, $parameter2, 2)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_LOW)/g" "$file"
    sed -i "s/new NotificationChannel($parameter1, $parameter2, 3)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_DEFAULT)/g" "$file"
    sed -i "s/new NotificationChannel($parameter1, $parameter2, 4)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_HIGH)/g" "$file"
    sed -i "s/new NotificationChannel($parameter1, $parameter2, 5)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_MAX)/g" "$file"
    #    echo "Parameter 4: new NotificationChannel($parameter1,$parameter2,2)"
  fi
  #----------------------Toast.makeText--------------------------
  matches=()
  while IFS= read -r line; do
    matches+=("$line")
  done < <(grep -o 'Toast\.makeText([^;]*);' "$file")
  for match in "${matches[@]}"; do
    echo "$match"
    # Remove leading and trailing whitespace
    string=$(echo "$match" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    # Extract parameters
    IFS=',' read -r -a params <<<"${string#Toast.makeText(}"
    context=$(echo "${params[0]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    message=$(echo "${params[1]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    #     duration=$(echo "${params[2]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/)//')
    sed -i "s/Toast.makeText($context, $message, 0)/Toast.makeText($context, $message, Toast\.LENGTH_SHORT)/g" "$file"
    sed -i "s/Toast.makeText($context, $message, 1)/Toast.makeText($context, $message, Toast\.LENGTH_LONG)/g" "$file"
  done
  #---------------------- Delete unnecessary files--------------------------
  # Delete unnecessary files
  #    name_with_ext=$(basename "$file")
  #    if [[ " ${delete_file_list[@]} " =~ "$name_with_ext" ]]; then
  #      rm "$item"
  #    fi
  #--------------------- Calculate the percentage of files processed-------------------------
  ((replace_files++))
  # Calculate the percentage of files processed
  percentage=$((replace_files * 100 / total_files))
  echo "Progress: $percentage% ($replace_files/$total_files files)"
  #--------------------- Calculate the percentage of files processed-------------------------
done
#--------------------- Calculate the percentage of files processed-------------------------
