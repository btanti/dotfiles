#!/usr/bin/env bash

note_dir=~/Documents/notes/daily/"$(date -I)"
if ! [[ -d "$note_dir" ]]; then
    mkdir "$note_dir"
fi

kitty -e --name scratch nvim $note_dir/note.txt -c :startinsert -c "normal! g\`\""
