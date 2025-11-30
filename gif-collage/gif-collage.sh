#!/bin/sh

input_file="$1"
width_tiles=4
height_tiles=4
width_pixels=468

total_tiles=$((width_tiles*height_tiles))
filter_inputs="$(python -c "print('[0]' * ${total_tiles})")"

ffmpeg -i "${input_file}" \
    -filter_complex "${filter_inputs}xstack=grid=${width_tiles}x${height_tiles}[v];[v]scale=width=${width_pixels}:height=-1" \
    out.mp4
