#!/usr/bin/env sh
xrandr --output DP-0 --primary
xrandr --output HDMI-0 --left-of DP-0
xrandr --output DP-4 --right-of DP-0
