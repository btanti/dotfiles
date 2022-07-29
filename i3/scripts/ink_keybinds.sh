#!/usr/bin/env bash

read -r X Y WIDTH HEIGHT < <(xdotool getwindowfocus getwindowgeometry --shell | sed -nE 'N;N;N;N;s/.*X=([0-9]+)\nY=([0-9]+)\nWIDTH=([0-9]+)\nHEIGHT=([0-9]+).*/\1 \2 \3 \4/p')

center_y=$((3 * $HEIGHT/4))
center_x=$(($WIDTH/2))

~/.config/rofi/bin/launcher_ink_prompt
