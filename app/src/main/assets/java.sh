#!/bin/bash
# StepConter

# "Enter the path of the directory containing the files: " ProjectName
echo "Enter the path of the directory containing the files: "
read PakageName

# search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
rPakageName="import $PakageName.R"

search_path="C:/AndroidProject/StepConter/app/src/main/java"
# Find all Java files in the specified path and its subdirectories
java_files=$(find "$search_path" -type f -name '*.java')
# Iterate over each Java file and perform the replacement
for file in $java_files; do
    sed -i "s/$rPakageName/import com.demo.example.R;/g" "$file"
    sed -i 's/getVisibility() != 0/getVisibility() != View.VISIBLE/g' "$file"
    sed -i 's/setScrollBarStyle(33554432)/setScrollBarStyle(View.SCROLLBARS_OUTSIDE_OVERLAY)/g' "$file"
    sed -i 's/? 8 : 0/? View.GONE : View.VISIBLE/g' "$file"
    sed -i 's/import com.google.android.gms.ads.appopen.AppOpenAd;//g' "$file"
    sed -i 's/import com.google.firebase.iid.FirebaseInstanceId;//g' "$file"
    sed -i 's/import com.google.firebase.iid.InstanceIdResult;//g' "$file"
    sed -i 's/import com.google.android.gms.tasks.Task;//g' "$file"
    sed -i 's/import com.google.android.gms.tasks.OnCompleteListener;//g' "$file"
    sed -i 's/import com.google.android.gms.tasks.OnCompleteListener;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.GoogleMap;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.OnMapReadyCallback;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.OnMapReadyCallback;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.SupportMapFragment;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.SupportMapFragment;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.model.LatLng;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.model.LatLng;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.model.MarkerOptions;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.model.MarkerOptions;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.model.PolylineOptions;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.model.PolylineOptions;//g' "$file"
    sed -i 's/import com.google.android.gms.maps.CameraUpdateFactory;//g' "$file"
    sed -i 's/import androidx.constraintlayout.solver.widgets.analyzer.BasicMeasure;//g' "$file"
    sed -i 's/import com.google.firebase.messaging.FirebaseMessagingService;//g' "$file"
    sed -i 's/import import com.google.firebase.messaging.RemoteMessage;//g' "$file"
    sed -i 's/import com.google.ads.consent.ConsentInfoUpdateListener;//g' "$file"
    sed -i 's/import com.google.ads.consent.ConsentInformation;//g' "$file"
    sed -i 's/import com.google.ads.consent.ConsentStatus;//g' "$file"
    sed -i 's/import com.google.ads.mediation.admob.AdMobAdapter;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.AdListener;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.interstitial.InterstitialAdLoadCallback;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.interstitial.InterstitialAd;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.LoadAdError;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.AdView;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.AdSize;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.AdRequest;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.AdListener;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.FullScreenContentCallback;//g' "$file"
    sed -i 's/import com.google.android.gms.ads.AdError;//g' "$file"
    sed -i 's/import androidx.lifecycle.ProcessLifecycleOwner;//g' "$file"
    sed -i 's/import com.google.firebase.FirebaseApp;//g' "$file"
    sed -i 's/import androidx.multidex.MultiDexApplication;//g' "$file"
    sed -i 's/import androidx.multidex.MultiDex;//g' "$file"
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
    sed -i 's/67108864/Intent.FLAG_ACTIVITY_CLEAR_TOP/g' "$file"
    sed -i 's/268435456/Intent.FLAG_ACTIVITY_NEW_TASK/g' "$file"
done

# for file in $java_files; do
#     if [[ -f "$file" && "$file" == "BuildConfig" ]]; then
#         echo "Deleting file: $file"
#         rm "$file"
#     fi
# done
# pattern1='<(\w+)\s+[^>]*name="common_[^"]*"[^>]*>(.*?)<\/\1>'
# replacement=''
# # Loop through all files in the directory
# for file in "$regexDir"/*; do
#   if [[ -f "$file" ]]; then
#     # Execute the sed command on each file
#     # sed -i s/replacement/000000/g "$file"
#     sed -Ei "s/$pattern1/$replacement/g" "$file"
#   fi
# done






