#!/bin/bash
# StepConter

echo "Enter the path of the directory containing the files: "
read ProjectName


layout_file="C:/AndroidProject/$ProjectName/app/src/main/res/layout/activity_main.xml"

sed -Ei 's/Of="0"/Of="parent"/g' $layout_file

