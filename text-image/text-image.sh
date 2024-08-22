#!/bin/bash

tmp_dir=$(mktemp -d)

size="$1"
color1="$2"
color2="$3"
text1="$4"
text2="$5"
font="$6"
delay="$7"
out_filename="$8"

shift 8

magick -size "$size" -background "$color1" -fill "$color2" -font "$font" -gravity center label:"$text1" "$tmp_dir/text1.gif"
magick -size "$size" -background "$color2" -fill "$color1" -font "$font" -gravity center label:"$text2" "$tmp_dir/text2.gif"

i=0
for img in "$@"; do
  frame=$((i++))
  cp "$tmp_dir/text1.gif" "$tmp_dir/$(printf 'frame%03d.gif' $frame)"
  frame=$((i++))
  cp "$tmp_dir/text2.gif" "$tmp_dir/$(printf 'frame%03d.gif' $frame)"
  frame=$((i++))
  magick "$img" -resize "$size^" -gravity center -crop "$size+0+0" +repage "$tmp_dir/$(printf 'frame%03d.gif' $frame)"
done

magick -size "$size" -delay "$delay" -loop 0 "$tmp_dir/frame"* "$out_filename"

rm -rf "$tmp_dir"
