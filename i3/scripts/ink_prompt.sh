#!/usr/bin/env bash

if [ $# -ne 0 ]
then
    echo $@
    exit 0
else
    echo -en "\0prompt\x1f > \n"
fi
