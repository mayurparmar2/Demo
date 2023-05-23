#!/bin/bash
# WifiAutoConnect

# "Enter the path of the directory containing the files: " ProjectName
echo "Enter the PakageName: "
read PakageName
#
echo "Enter the ProjectName: "
read ProjectName

#search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
#rPakageName="import $PakageName.R;"
#
#PakageName='auto.move.to.sd.card.quick.transfer'
#ProjectName='AutoMoveSdcard'
search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
java_files=$(find "$search_path" -type f -name '*.java')
total_files=$(echo "$java_files" | wc -l)
replace_files=0

delete_file_list=(
  "R.java"
  "BuildConfig.java"
)
percentage=0
for file in $java_files; do
  sed -i "s/import $PakageName.R;/import com.demo.example.R;/g" "$file"
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
    sed -i "s/new NotificationChannel($parameter1, $parameter2, 2)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_LOW)/g" "$file"
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
         IFS=',' read -r -a params <<< "${string#Toast.makeText(}"
         context=$(echo "${params[0]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
         message=$(echo "${params[1]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    #     duration=$(echo "${params[2]}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/)//')
        sed -i "s/Toast.makeText($context, $message, 0)/Toast.makeText($context, $message, Toast\.LENGTH_SHORT)/g" "$file"
        sed -i "s/Toast.makeText($context, $message, 1)/Toast.makeText($context, $message, Toast\.LENGTH_LONG)/g" "$file"
     done
#---------------------- Delete unnecessary files--------------------------
#  # Delete unnecessary files
#  name_with_ext=$(basename "$file")
#  if [[ " ${delete_file_list[@]} " =~ "$name_with_ext" ]]; then
#    rm "$item"
#  fi
#--------------------- Calculate the percentage of files processed-------------------------
  ((replace_files++))
  # Calculate the percentage of files processed
  percentage=$((replace_files * 100 / total_files))
  echo "Progress: $percentage% ($replace_files/$total_files files)"
#--------------------- Calculate the percentage of files processed-------------------------
done



