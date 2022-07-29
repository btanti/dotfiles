#!/usr/bin/env bash

EDITOR=zathura

CUR_DIR=~/Documents/notes

PREV_LOC_FILE=~/.rofi_fb_prevloc

## Read last location, otherwise we default to PWD.
#if [ -f "${PREV_LOC_FILE}" ]
#then
    #CUR_DIR=$(cat "${PREV_LOC_FILE}") 
#fi 

# Handle argument.
if [ -n "$@" ]
then
    CUR_DIR="${CUR_DIR}/$@"
fi

# If argument is no directory.
if [ ! -d "${CUR_DIR}" ]
then
    if [[ "${CUR_DIR}" =~ ^.*\.pdf$ ]]
    then
	coproc ( zathura "${CUR_DIR}" & >/dev/null 2>&1 )
	exit;
    elif [[ "${CUR_DIR}" =~ ^.*\.tex$ ]]
    then
	coproc ( kitty -e nvim "${CUR_DIR}" & >/dev/null 2>&1 )
	exit;
    elif [ -x "${CUR_DIR}" ]
    then
	coproc ( "${CUR_DIR}" &  > /dev/null 2>&1 )
	exec 1>&-
	exit;
    elif [ -f "${CUR_DIR}" ]
    then
	coproc ( ${EDITOR} "${CUR_DIR}" & > /dev/null  2>&1 )
	exit;
    fi
    exit;
fi

# process current dir.
if [ -n "${CUR_DIR}" ]
then
    CUR_DIR=$(readlink -e "${CUR_DIR}")
    echo "${CUR_DIR}" > "${PREV_LOC_FILE}"
    pushd "${CUR_DIR}" >/dev/null
fi

echo -en "\0prompt\x1f search:\n"
echo ".."
# Print formatted listing
#ls --group-directories-first --color=never --indicator-style=slash | egrep '/$|\.tex$|\.pdf$'
find . -type f \( -name "*.pdf" -o -name "*.tex" \) | sort | cut -c 3-
