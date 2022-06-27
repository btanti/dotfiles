#!/usr/bin/env sh
xrandr --output DP-2 --primary
xrandr --output HDMI-0 --left-of DP-2
xrandr --output DP-0 --right-of DP-2
