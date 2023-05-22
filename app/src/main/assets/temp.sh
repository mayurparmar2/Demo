#!/bin/bash


#!/bin/bash

# XML file path
xml_file="C:/AndroidProject/StepConter/app/src/main/res/values/styles.xml"

string='<style name="Animation.MaterialComponents.BottomSheetDialog" parent="@style/Animation.AppCompat.Dialog">
    <item name="android:windowEnterAnimation">@anim/mtrl_bottom_sheet_slide_in</item>
    <item name="android:windowExitAnimation">@anim/mtrl_bottom_sheet_slide_out</item>
</style>
<style name="AppTheme" parent="@style/Theme.AppCompat.Light.NoActionBar">
    <item name="colorAccent">@color/colorAccent</item>
    <item name="colorControlNormal">#ffffff</item>
    <item name="colorPrimary">@color/colorPrimary</item>
    <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
</style>
<style name="Base.AlertDialog.AppCompat" parent="@android:style/Widget">
    <item name="android:layout">@layout/abc_alert_dialog_material</item>
    <item name="buttonIconDimen">@dimen/abc_alert_dialog_button_dimen</item>
    <item name="listItemLayout">@layout/select_dialog_item_material</item>
    <item name="listLayout">@layout/abc_select_dialog_material</item>
    <item name="multiChoiceItemLayout">@layout/select_dialog_multichoice_material</item>
    <item name="singleChoiceItemLayout">@layout/select_dialog_singlechoice_material</item>
</style>'

commented_string=$(echo "$string" | awk '/<style name="AppTheme"|<style name="Base.AlertDialog.AppCompat"/,/<\/style>/{print; next}{print "<!--" $0 "-->"}')

echo "$commented_string" > commented_styles.txt





#----------------------commented_styles sucess--------------------------
#file="C:/AndroidProject/StepConter/app/src/main/res/values/styles.xml"
#commented_string=$(cat "$file" | awk '/<style name="AppTheme"/,/<\/style>/{print; next}{print "<!--" $0 "-->"}')
#
#echo "$commented_string" > "$file"
#echo "$commented_string" > commented_styles.xml
#------------------------------------------------
#set +H  # Disable history expansion
#manifest="C:/AndroidProject/StepConter/app/src/main/AndroidManifest.xml"
#style_name=$(grep -oP 'android:theme="@style/\K[^"]+' $manifest)
#echo "Theme theme_name => '$style_name'"
#style_name="AppTheme"
#file="C:/AndroidProject/StepConter/app/src/main/res/values/styles.xml"
# if [[ -f "$file" ]]; then
#    echo "style.xml file is found"
#fi
#echo "Theme theme_name => '$style_name'"
#------------------------------------------------
#sed -i "/<style name=\"$style_name\"/,/<\/style>/ s/^<!--\([^!]*\)-->$/\1/" "$xml_file"
#sed -i "/<style name=\"$style_name\">/,/<\/style>/ s/^<!--\(.*\)-->/\1/" "$xml_file"
#------------------------------------------------
#ProjectName='AutoMoveSdcard'
#java_file_path="C:/AndroidProject/$ProjectName/app/src/main/java/auto/move/to/sd/card/quick/transfer/utils/NotifiactionUtilsMove.java"
##notification_channel="new NotificationChannel(Ostr3423, Mst4242r2, 2)"
#notification_channel=$(cat "$java_file_path" | grep -o -P "new NotificationChannel\(([^)]+)\)")
#regex="new NotificationChannel\(([^,]+),\s*([^,]+),\s*([^)]+)\)"
#echo "notification_channel : $notification_channel"
#echo "regex : $regex"
#if [[ $notification_channel =~ $regex ]]; then
#  parameter1=${BASH_REMATCH[1]}
#  parameter2=${BASH_REMATCH[2]}
#  parameter3=${BASH_REMATCH[3]}
#
#    parameter1=${parameter1//[[:space:]]/}
#    parameter2=${parameter2//[[:space:]]/}
#    parameter3=${parameter3//[[:space:]]/}
##  sed -i "s/new NotificationChannel($parameter1, $parameter2, 2)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_LOW)/g" "$java_file_path"
#  sed -i "s/new NotificationChannel($parameter1, $parameter2, 2)/new NotificationChannel($parameter1, $parameter2, NotificationManager\.IMPORTANCE_LOW)/g" "$java_file_path"
#  echo "Parameter 1: $parameter1"
#  echo "Parameter 2: $parameter2"
#  echo "Parameter 3: $parameter3"
#  echo "Parameter 4: new NotificationChannel($parameter1,$parameter2,2)"
#fi

#------------------------------------------------
# "Enter the path of the directory containing the files: " ProjectName
#echo "Enter the PakageName: "
#read PakageName
#
#echo "Enter the ProjectName: "
#read ProjectName

#search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
#rPakageName="import $PakageName.R;"

#PakageName='auto.move.to.sd.card.quick.transfer'
#ProjectName='AutoMoveSdcard'
##search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
##java_files=$(find "$search_path" -type f -name '*.java')
##
##for file in $java_files; do
##  sed -i 's/268435456/Intent.FLAG_ACTIVITY_NEW_TASK/g' "$file"
##done
#
#search_path="C:/AndroidProject/$ProjectName/app/src/main/java"
#java_files=$(find "$search_path" -type f -name '*.java')
#
#total_files=$(echo "$java_files" | wc -l)
#replace_files=0
#
#for file in $java_files; do
#  sed -i 's/268435456/Intent.FLAG_ACTIVITY_NEW_TASK/g' "$file"
#  ((replace_files++))
#
#  # Calculate the percentage of files processed
#  percentage=$((replace_files * 100 / total_files))
#  echo "Progress: $percentage% ($replace_files/$total_files files)"
#done
#
#echo "Total files: $total_files"
#echo "Files replaced: $replace_files"
#echo "Percentage processed: $percentage%"
#



