#!/bin/bash

#Screen background feh

pics=(/home/koe/Dokumente/Sync/Pictures/Wallpaper/b_*)
len=${#pics[*]}
ran=$(($RANDOM % len))

feh --bg-max ${pics[$ran]}

unset pics len ran