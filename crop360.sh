#!/usr/bin/env bash

dir="input"
outputDir="output"

mkdir -p $outputDir

find $dir \( -iname "*.jpg" \) -print0 | \
   while read -d $'\0' -r image; do
      read w h < <(sips -g pixelWidth -g pixelHeight "$image" | awk '/Width:/{w=$2} /Height:/{h=$2} END{print w " " h}')
      read file < <(basename ${image%.*})
      jpegtran -copy all -crop $((w/2))x$h+0+0 -perfect $image > $outputDir/$file-1.jpeg
      jpegtran -copy all -crop $((w/2))x$h+$((w/2))+0 -perfect $image > $outputDir/$file-2.jpeg
   done
