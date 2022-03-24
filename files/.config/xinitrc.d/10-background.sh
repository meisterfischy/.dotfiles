#!/bin/bash

#Screen background feh

pics=(/home/koe/Nextcloud/Pics/Wallpaper/b_*)
len=${#pics[*]}
ran=$(($RANDOM % len))

feh --bg-fill ${pics[$ran]}

unset pics len ran
