#!/bin/sh

input_file="$1"
width_tiles="${2:-5}"
height_tiles="${3:-5}"
width_pixels="${4:-500}"

total_tiles=$((width_tiles*height_tiles))
filter_inputs="$(python -c "print('[0]' * ${total_tiles})")"
output_filename="$(basename "${input_file}")__${width_tiles}x${height_tiles}-${width_pixels}.mp4"

ffmpeg -i "${input_file}" \
    -filter_complex "${filter_inputs}xstack=grid=${width_tiles}x${height_tiles}[v];[v]scale=width=${width_pixels}:height=-1" \
    "${output_filename}"
