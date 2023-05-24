<item>@drawable/background_bottom_sheet_bottom_sheet</item><item>@drawable/background_bottom_sheet_bottom_sheet</item><item>@drawable/background</item>
how to replace '@drawable/background' to new '@drawable/new_background' without selecting half word using bash

itemJava="C:/AndroidProject/Test/VideoDownloader/app/src/main/res/values/styles.xml"
sed -i 's/\@drawable\/background\([^_[:alnum:]\)/\@drawable\/sdsd/g' "$itemJava"

