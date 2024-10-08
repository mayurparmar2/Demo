#!/bin/bash
#echo "Enter the path of the directory containing the files: "
#read ProjectName
ProjectName="PhotoMixerV117"
renamed_directory=0
percentage=0
directory="F:/AndroidProject/Test/$ProjectName/app/src/main/java"
#main_path="F:/AndroidProject/Test/$ProjectName/app/src/main"
directorieslist=(
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/arrays.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/attrs.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/colors.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/dimens.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/strings.xml"
  "F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/styles.xml"
)
fun_random_string() {
  random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
  # Ensure the string doesn't start with a number or uppercase letter
  while [[ "$random_string" =~ ^[0-9A-Z] ]]; do
    random_string=$(cat /dev/urandom | tr -dc 'a-z' | fold -w 10 | head -n 1)
  done
  echo "$random_string"
}



replace_java_name() {
  random_string="$1"
  file_name_without_extension="$2"
  main_path="$3"
  main_file="$4"

  #
  #
  #  package="$(echo "${main_file%/*}" | sed 's|[^;]*/app/src/main/java/||g' | sed 's|/|.|g')"
  #  list_java2=$(grep -r --include='*.java' -l "\bimport $package.$file_name_without_extension;\b" "$main_path")
  #  for itemJava2 in $list_java2; do
  #    sed -i -e "s/import $package.$file_name_without_extension;/import $package.$random_string;/g" "$itemJava2"
  #  done

  list_java=$(grep -r --include='*.java' -l "\b$file_name_without_extension\b" "$main_path")
  for itemJava in $list_java; do
    #    echo "$itemJava"
     sed -i '/import [^;]*;/! s/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"

#    sed -i '/import [^;]*;/! s/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
    #    sed -i '/import [^;]*;/! s/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
    #     sed -i -e "s/\.$file_name_without_extension;/\.$random_string;/g" "$itemJava"
    #    sed -i 's/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
  done









  #
  #  list_java=$(grep -r --include='*.java' -l "\b$file_name_without_extension\b" "$main_path")
  #  for itemJava in $list_java; do
  #    #    echo "$itemJava"
  #    sed -i -e 's/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
  #    #    sed -i '/import [^;]*;/! s/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
  #    #     sed -i -e "s/\.$file_name_without_extension;/\.$random_string;/g" "$itemJava"
  #    #    sed -i 's/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
  #  done
  #
    package="$(echo "${main_file%/*}" | sed 's|[^;]*/app/src/main/java/||g' | sed 's|/|.|g')"
    list_java2=$(grep -r --include='*.java' -l "$package" "$main_path")
    for itemJava2 in $list_java2; do
         echo -e "Package =>  $package \n File =>  $itemJava2 To => $random_string" >>name.xml
#       package="$(echo "${itemJava2%/*}" | sed 's|[^;]*/app/src/main/java/||g' | sed 's|/|.|g')"
       sed -i "s/import $package.$file_name_without_extension/import $package.$random_string/g" "$itemJava2"
#      sed -i -e "/package [^;]*;/! s/import $package.$file_name_without_extension;/import $package.$random_string;/g" "$itemJava2"
    done
  #
  #  list_xml=$(grep -r --include='*.xml' -l ''$package'.'file_name_without_extension'' "$(dirname "$main_path")")
  #  for itemXml in $list_xml; do
  #    sed -i -e "s/$package\.$file_name_without_extension/$package\.$random_string/g" "$itemXml"
  #    #    sed -i -e 's/<'$package'.'$file_name_without_extension'/<'$package'.'$random_string'/g' "$itemXml"
  #    #    sed -i -e 's/"'$package'.'$file_name_without_extension'"/"'$package'.'$random_string'"/g' "$itemXml"
  #  done

}
#replace_java_import() {
#  random_string="$1"
#  file_name_without_extension="$2"
#  main_path="$3"
#  main_file="$4"
#  echo -e "Package =>  $package \n File =>  $main_file To => $random_string" >>import.xml
#  package="$(echo "${main_file%/*}" | sed 's|[^;]*/app/src/main/java/||g' | sed 's|/|.|g')"
#  list_java2=$(grep -r --include='*.java' -l "\bimport $package.$file_name_without_extension;\b" "$main_path")
#  for itemJava2 in $list_java2; do
#    sed -i "s/import $package.$file_name_without_extension;/import $package.$random_string;/g" "$itemJava2"
#  done
#}

src_files=$(find "$directory" -type f -name '*.java')
total_files=$(echo "$src_files" | wc -l)

for file in $src_files; do
  current_name_ext=$(basename "$file")
  extension="${current_name_ext##*.}"
  file_name_without_extension="${current_name_ext%.*}"
  random_string=''$file_name_without_extension'_'$(fun_random_string)''
  if [[ -f "$file" ]]; then
    replace_java_name "$random_string" "$file_name_without_extension" "$directory" "$file"
    mv "$file" "$(dirname "$file")/$random_string.$extension"
#    replace_java_import "$random_string" "$file_name_without_extension" "$directory" "$file"
    #    mv "$file" "$dir/$random_string.$extension"
  fi
  #--------------------- Calculate the percentage of files processed-------------------------
  ((renamed_directory++))
  # Calculate the percentage of files processed
  percentage=$((renamed_directory * 100 / total_files))
  echo "Progress: $percentage% ($renamed_directory/$total_files files)"
  #--------------------- Calculate the percentage of files processed-------------------------
done

#--------------------- Calculate the percentage of files processed-------------------------


#itemJava="F:/AndroidProject/Test/HomeWorkout/app/src/main/java/com/demo/exercise_app/activites/AddedCustomExercisesListActivity.java"
#package="$(echo "${itemJava%/*}" | sed 's|[^;]*/app/src/main/java/||g' | sed 's|/|.|g')"
#file_name_without_extension="AddedCustomExercisesListActivity"
#random_string="AddedCustomExercisesListActivity_new"
#sed -i '/import [^;]*;/! s/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
#sed -i "s/import $package.$file_name_without_extension;/import $package.$random_string;/g" "$itemJava"


#--------------------- Calculate the percentage of files processed-------------------------

#Package = >com.demo.exercise_app.Utils
#File = To = >F:/AndroidProject/Test/HomeWorkout/app/src/main/java/com/demo/exercise_app/Utils/Utils.java >Utils_hkjvyxojms
#Package = >com.demo.exercise_app
#list_java=$(grep -r --include='*.java' -l "\b$file_name_without_extension\b" "$main_path")
#for itemJava in $list_java; do
#  #    echo "$itemJava"
#done

#    sed -i '/import [^;]*;/! s/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
#     sed -i -e "s/\.$file_name_without_extension;/\.$random_string;/g" "$itemJava"
#    sed -i 's/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
#
#mv "$file" "$new_file"

#main_path="F:/AndroidProject/Test/HomeWorkout/app/src/main/java"
#package="com.demo.exercise_app.Utils.CalenderView"
#file_name_without_extension="CalendarGridView"
#random_string="NewCalendarGridView"
#list_xml=$(grep -r --include='*.xml' -l "$package" "$(dirname "$main_path")")
#for itemXml in $list_xml; do
#  sed -i -e "s/$package\.$file_name_without_extension/$package\.$random_string/g" "$itemXml"
#done
#
#main_file="F:/AndroidProject/Test/HomeWorkout/app/src/main/res/layout/calendar_view_grid.xml"
#echo "$(dirname "$main_file")"
#
#sed -i -e 's/<'$package'.'$file_name_without_extension'/<'$package'.'$random_string'/g' "$itemXml"
#
#sed -i -e 's/"'$package'.'$file_name_without_extension'"/"'$package'.'$random_string'"/g' "$itemXml"

#itemJava="F:/AndroidProject/GitHubDemo/app/src/main/java/com/demo/example/App.java"
#str="$(echo "${itemJava%/*}" | sed 's|[^;]*/app/src/main/java/||g' | sed 's|/|.|g')"
#
#sed -i -e "s/import $str.App;/import $str.new;/g" "$itemJava"
#echo "$str"

#str="$(echo "${itemJava%/*}" | sed 's|[^;]*/app/src/main/java/||g' | sed 's|/|.|g')"
#sed -i -e "s/import com.demo.App.example;/import com.demo.App.examplenew;/g" "$itemJava"
#echo "$str"
#
#echo "$(echo "$str" | sed 's|/|.|g')"
#
#
#path="F:/AndroidProject/GitHubDemo/app/src/main/java/com/demo/example/App.java"
#echo "${path%/*}"
#echo "$(basename "$path")"
#
#
#path="F:/AndroidProject/GitHubDemo/app/src/main/java/com/demo/example/App.java"
#package=$(echo "$path" | sed 's/\//./g')
#package2=$(echo "$package" | sed 's/F:\.AndroidProject\.GitHubDemo\.app\.src\.main\.java\.\///')
#echo "$package2"
#F:.AndroidProject.GitHubDemo.app.src.main.java.
# | sed 's/F:\.AndroidProject\.GitHubDemo\.app\.src\.main\.java\///'
#
##!/bin/bash
#str="import android.app.Application;
#    import com.demo.App.example;
#    import com.demo.example.App;
#    import android.content.Context;"
#
#name=$(echo "$str" | sed -e "s/\.App;/\.newAppApp;/g")
#echo "$name"
#
#
#
#com.demo.exercise_app.Utils.CustomSharedPreference
#
#
#echo "import android.app.Application.a121;
#import com.demo.App.example.a122;
#import com.demo.example.App.a123;
#import android.content.Context.a124;" | grep -o '[^ ]*;' | awk -F'[ .;]' '{print $(NF-1)}'
#
#echo "import android.app.Application;
#import com.demo.App.example;
#import com.demo.example.App;
#import android.content.Context;" | grep -o '*[^ ]' | awk -F'[;]' '{print $(NF-1)}'
#
##/import [^;]*;/!
#import android.app;
#import com.demo.App;
#import com.demo.example;
#import android.content;
#
#
#
#
#echo "import android.app.Application;
#import com.demo.App.example;
#import com.demo.example.App;
#import android.content.Context;" | grep -oE '[^;]+'
#
#echo "import android.app.Application.;
#      import com.demo.App.example;
#      import com.demo.example.App;
#      import android.content.Context;" | grep -o '[^ ]*;' | awk -F'[.]' '{print $(NF-1)}'
#
#
#itemJava="F:/AndroidProject/GitHubDemo/app/src/main/java/com/demo/example/App.java"
#substring=$(cat "$itemJava" | sed -e 's/import [^;]*Application;\.//')
#echo "$substring"
#
#string="import 'com.demo.App.example'"
#last_word=$(echo "$string" | cut -d ' ' -f -2)
#echo "$last_word"
#import com.demo.App
#
#string="import 'com.demo.App.example'"
#last_word=$(echo "$string" | awk '{print $NF}')
#echo "$last_word"
#
#
#import com.demo.App
#
#import com.demo.App
#
#
#
#
#last_import=$(tac $itemJava | grep -P "import [^;]*Application;")
#sed -i -e '/\(.*\)\.[^.]*$/! s/\bApp\b/NewClassName/g' "$itemJava"
#
#
# sed -i '/import [^;]*;/! s/\([^"]\|^\)\b'$file_name_without_extension'\b\([^"]\|$\)/\1'$random_string'\2/g' "$itemJava"
# echo 'import android.app.Application;
#       import com.demo.App.example;
#       import com.demo.example.App;
#       import android.content.Context;
#       public class NewClassName extends Application {
#           private final String TAG = "NewClassName";
#       }' | sed -e '/\(.*\)\.[^.]*$/! s/\bApp\b/NewClassName/g'
#
#
# echo '"import android.app.Application.content;
# import com.demo.App.example.content;
# import com.demo.example.App.content;' | sed 's/\(.*\)\.[^.]*$/\1/'
#
#
#echo "import com.demo.example.App; import android.content.Context;" | grep -o '[^ ]*;' | awk -F'[ .]' '{print $(NF-1)}'
#
#
#sed -i -e '/s/\(.*\)\.[^.]*$/\1/! s/\bApp\b/NewClassName/g' YourFile.java
#
#
#
#
#last_import=$(tac $YourDirectory | grep -m 1 -oP "import .*?\K\w+")
#echo "$last_import"
#
#last_import=$(tac $YourDirectory | grep -P "import [^;]*Application;")
#echo "$last_import"
#grep -rl --exclude-dir=dirToExclude "public class App" $YourDirectory | xargs sed -i '/^import .*20;$/! s/\bApp\b/NewClassName/g'
#
#
#
#sed -i '/import .*1;/! s/\bApp\b/NewClassName/g' "$YourDirectory"
#
#grep -rl --exclude-dir=dirToExclude "public class App" $YourDirectory | xargs sed -i '/import [^;]*;/! s/\bApp\b/NewClassName/g'

#
#
#grep -rl --exclude-dir=dirToExclude "public class App" $YourDirectory | xargs sed -i '/^import com.App.demo;$/! s/App/NewClassName/g'
#
#
#grep -rl --exclude-dir=dirToExclude "public class App" $YourDirectory | xargs sed -i 's/\([^a-zA-Z0-9_]\|^\)App\([^a-zA-Z0-9_]\|$\)/\1NewClassName\2/g'
#
#grep -rl --exclude-dir=dirToExclude "public class App" YourDirectory | xargs awk '!/import com.demo.App.example/{print}' | xargs sed -i 's/\([^a-zA-Z0-9_]\|^\)App\([^a-zA-Z0-9_]\|$\)/\1NewClassName\2/g'
#
#grep -rIl --exclude-dir=dirToExclude "import com.demo.App.example;" $YourDirectory | xargs sed -i 's/\([^a-zA-Z0-9_]\|^\)App\([^a-zA-Z0-9_]\|$\)/\1NewClassName\2/g'

#for dir in "$directory"/*; do
#  src_files=$(find "$directory" -type f -name '*.*')
#  total_files=$(echo "$src_files" | wc -l)
#  # Check if directory exists
#  if [[ -d "$dir" ]]; then
#    bir_name="$(basename "$dir")"
#    #    IFS='-' read -ra parts <<<"$bir_name"
#    #    if [ "${#parts[@]}" -gt 1 ]; then
#    #      bir_name="${parts[0]}"
#    #    fi
#    for file in "$dir"/*; do
#      #      if [[ " ${directorieslist[@]} " =~ " $file " ]]; then
#      #        echo "Skipping file: $dir"
#      #      else
#      current_name_ext=$(basename "$file")
#      extension="${current_name_ext##*.}"
#      file_name_without_extension="${current_name_ext%.*}"
#      random_string=''$file_name_without_extension'_'$(fun_random_string)''
#      if [[ -f "$file" ]]; then
#        replace_java_files "$random_string" "$file_name_without_extension" "$main_path"
#        mv "$file" "$dir/$random_string.$extension"
#      fi
#      #      fi
#      #--------------------- Calculate the percentage of files processed-------------------------
#      ((renamed_directory++))
#      # Calculate the percentage of files processed
#      percentage=$((renamed_directory * 100 / total_files))
#      echo "Progress: $percentage% ($renamed_directory/$total_files files)"
#      #--------------------- Calculate the percentage of files processed-------------------------
#    done
#  fi
#done

#declare -a file_list
#declare -a my_java_list
#declare -a my_xml_list
#list_and_print_files() {
#  directory="$1"
#  filename="$2"
#  new_filename="$3"
#  # Use find command to search for files with similar names
#  files=$(find "$directory" -name "${filename}.*")
#  for file in $files; do
#    #      path="${paths[$i]}"
#    if [[ " ${file_list[@]} " =~ " $file " ]]; then
#      echo "Skipping file: $file"
#    else
#      new_file="${file/$filename/$new_filename}"
#      mv "$file" "$new_file"
#      file_list+=("$new_file")
#      #      echo "Renamed file $file to $new_file"
#    fi
#  done
#}

#"s/R\.$bir_name\.$file_name_without_extension\([^_]\)/R.$bir_name.$random_string\1/g"
#R.drawable.direct_download
#itemJava="F:/AndroidProject/Test/$ProjectName/app/src/main/java/com/demo/videodownloader/twitter_module/ui/Activity_Twitter.java"
#bir_name="drawable"
#file_name_without_extension="background_bottom_sheet"
#  main_path="F:/AndroidProject/Test/$ProjectName/app/src/main"
#  list_xml=$(grep -r --include='*.xml' -l '>@'$bir_name'/'$file_name_without_extension'<' "$main_path")
#  for itemXml in $list_xml; do
#    sed -i "s,>$pattern<,>$replacement<,g" "$itemXml"
#  done
#
#bir_name="drawable"
#file_name_without_extension="background_bottom_sheet"
#random_string="new_background_bottom_sheet"
#pattern="@$bir_name/$file_name_without_extension"
#replacement="@$bir_name/$random_string"
#sed -i "s,>$pattern<,>$replacement<,g" "$itemJava"
#
##sed -i '0,/@drawable\/background/s//@drawable\/bottom/' "$itemJava"
#
#new_string=$(echo "$string" | sed "s/<item[^>]*>[^<]*<\/item>/$replacement/g")
#
#string='<style name="AppModalStyle" parent="@style/Widget.Design.BottomSheet.Modal">
#        <item name="android:background">@drawable/background_bottom_sheet</item>
# <item name="android:background">@drawable/background_bottom_sheet2</item>
#    </style>'
#replacement="@drawable/background_new"
#new_string=$(echo "$string" | sed "s,>@drawable/background_bottom_sheet<,$replacement,g")
#echo "$new_string"
#
#bir_name="drawable"
#file_name_without_extension="background_bottom_sheet"
#random_string="new_background_bottom_sheet"
##pattern="\@$bir_name\/$file_name_without_extension"
##riplace="\@$bir_name\/$random_string"
## Perform the replacement (only the first occurrence)
#updated_content=$(cat "$itemJava" | sed '0,/@'$bir_name'\/'file_name_without_extension'/s//@'$bir_name'\/'random_string'/')
## Write the updated content to a temporary file
#echo "$updated_content" >"$itemJava"
#
#sed -i '0,/@'$bir_name'\/'file_name_without_extension'/s//@'$bir_name'\/'random_string'/' "$itemJava"
#
#string='<style name="AppModalStyle" parent="@style/Widget.Design.BottomSheet.Modal">
#        <item name="android:background">@drawable/bottom_sheet</item>
# <item name="android:background">@drawable/bottom_sheet2</item>
#    </style>'
#
#sed -i '0,/@drawable\/bottom_sheet/s//@layout\/bottom/' "$string"
#
#echo "$string"
#
#string='<style name="AppModalStyle" parent="@style/Widget.Design.BottomSheet.Modal">
#        <item name="android:background">@drawable/bottom_sheet</item>
# <item name="android:background">@drawable/bottom_sheet2</item>
#    </style>'
#
#echo "$updated_string"
#
#sed -i "s/$pattern/$riplace\1/g" "$itemJava"
#
#itemJava="F:/AndroidProject/Test/$ProjectName/app/src/main/res/values/styles.xml"
#bir_name="drawable"
#file_name_without_extension="background"
#random_string="new_background_bottom_sheet"
#pattern="\@$bir_name\/$file_name_without_extension"
#riplace="\@$bir_name\/$random_string"
#sed -i '0,/'$pattern' /{s/'$pattern'/'$riplace'/}' "$itemJava"
#
##/@drawable/background_bottom_sheet
#pattern="\@drawable\/background[^<]"
#riplace="\@drawable\/sdsd_bottom_sheet"
#sed -i "s/$pattern/$riplace/g" "$itemJava"
#sed -i 's/\>\@drawable\/background_bottom_sheet\</\>\@drawable\/new_background_bottom_sheet\</g' "$itemJava"
#
#sed -i 's/\>\@drawable\/background_bottom_sheet\</\>\_qthqroejrd\>/' "$itemJava"
#
#pattern="\>\@drawable\/background_bottom_sheet\<"
#riplace="\>\@drawable\/_qthqroejrd\<"
#sed -i "s/$pattern/$riplace/g" "$itemJava"
#
#list_xml2=$(grep -r --include='*.xml' -l '>@'$bir_name'/'$file_name_without_extension'<' "$main_path")
#for itemXml2 in $list_xml2; do
#  sed -i "s/\>\(@$bir_name\/\)$file_name_without_extension\</\>\1$random_string\</g" "$itemXml2"
#done

#sed -i "s/R\.drawable\.direct_download/R.drawable.direct_download_new/g" "$itemJava"
#F:\AndroidProject\Test\$ProjectName\app\src\main\java\com\demo\videodownloader\adapter
#itemJava="F:/AndroidProject/Test/$ProjectName/app/src/main/java/com/demo/videodownloader/adapter/Downloader_StoriesofInstagram_Adapter.java"
#sed -i '0,/itemsof/{s/\R\.layout\.itemsof_whatsapp_statuses_view\b/random_string/}' "$itemJava"
#sed -i '0,/items/{s/\bitems\b/random_string/}' filename
#
#sed -i "s/R\.layout\.items/R.layout.random_string/g" "$itemJava"
#
#echo "R.layout.R.layout.random_string_whatsapp_statuses_view" | sed -e "s/R\.layout\.activity_web_browser[^_[:alnum:][:space:]]*/R.layout.random_string/g"

#
#
#
#
#echo "R.drawable.direct_download" | sed -E "s/R\.layout\.activity_web_browser\([^_]\)/R.layout.random_string\1/g"
#
#
#echo "R.layout.activity_web_browser_list" | sed -e "s/R\.layout\.activity_web_browser\([^_]\)/R.layout.random_string\1/g"

#echo "R.layout.activity_web_browser_list" | sed -e "s/R\.layout\.activity_web_browser*\([^_]\)/R.layout.random_string\1/g"

#sed -i "s/R\.layout\.[a-zA-Z]*\([^_]\)/R.layout.random_string\1/g" WebBrowserList_Activity.java WebBrowser_Activity.java

#list_and_print_files "$main_path" "new_weather2" "weather123"
#list_and_print_files "$main_path" "new_weather2" "weather456"
#
##!/bin/bash
#
#check_item_in_list() {
#  item="$1"
#  list=("$@")
#
#  # Use conditional statement to check if the item is in the list
#  if [[ " ${list[*]} " == *" $item "* ]]; then
#    echo "Item '$item' exists in the list."
#  else
#    echo "Item '$item' does not exist in the list."
#  fi
#}
#
## Usage example
#check_item_in_list "item2" "item1" "item2" "item3"
