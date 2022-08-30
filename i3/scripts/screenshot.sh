theme="ss_prompt"
dir="$HOME/.config/rofi/launchers/text"

if [ $# -eq 1 ]
then
maim -o -s -u  > /tmp/tmp_screenshot.png && filename=$(rofi -dmenu -p "Save as: " -l 0 -theme $dir/$theme) && mv /tmp/tmp_screenshot.png ~/Pictures/Screenshots/$filename.png
else
maim -o -u  > /tmp/tmp_screenshot.png && filename=$(rofi -dmenu -p "Save as: " -l 0 -theme $dir/$theme) && mv /tmp/tmp_screenshot.png ~/Pictures/Screenshots/$filename.png
fi
