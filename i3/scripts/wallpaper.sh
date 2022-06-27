#!/usr/bin/env sh

# set user directory here
dir=~/Pictures/wallpapers/

bg=$(ls $dir | shuf -n1)
feh "$dir$bg" --bg-scale &
