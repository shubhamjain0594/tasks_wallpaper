#!/bin/bash

# a packet is number of lines in a column
packet=40
f1="/home/dora/task_wallpaper/tasks.txt"
bash_file="/home/dora/task_wallpaper/task_wallpaper.sh"
# retrieving text file from tasks.txt 
lines=$(wc -l < $f1)
echo "Number of lines are $lines"
i=1
declare -a files
# echo "sed -n '${i}p' < $f1"
while [[ $i -lt $lines ]]
do
end=$((i+packet))p
echo $end
files[$i]=$(sed -n "$i,$end" < $f1)
echo ${files[$i]}
i=$[$i+$packet+1]
done
# adding text to image 


match=\'
replace=\\\'

i=1
k=0
cp /home/dora/task_wallpaper/bg.jpg /home/dora/task_wallpaper/bg_final.jpg
while [[ $i -lt $lines ]]
do
width=$[k*700+300]
# echo "${files[26]}"
convert -font Helvetica -pointsize 30 -fill white -draw "text ${width},100 '${files[$i]/$match/$replace}' " /home/dora/task_wallpaper/bg_final.jpg /home/dora/task_wallpaper/bg_final.jpg
i=$[$i+$packet+1]
k=$[$k+1]
done

# setting the wallpaper

gsettings set org.gnome.desktop.background picture-uri 'file:///home/dora/task_wallpaper/bg_final.jpg'
while :; do 
inotifywait -e delete_self $f1 
bash $bash_file; 
done
