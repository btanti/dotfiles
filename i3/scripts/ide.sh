#!/usr/bin/env sh

landing=$1

i3-msg "workspace 1; append_layout ~/.dotfiles/i3/ide.json"

(kitty --name "ide_term" &)
(kitty --name "ide_code" -e nvim "$landing" &)
