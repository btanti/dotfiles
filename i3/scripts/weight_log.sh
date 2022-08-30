#!/usr/bin/env bash

note_dir=~/personal/fitness/

kitty -e --name scratch nvim $note_dir/weight_log.txt -c "nnoremap <buffer> <esc> :wq<cr>"   -c :startinsert -c "normal! g\`\""
