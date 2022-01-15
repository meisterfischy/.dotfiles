#!/bin/sh

setxkbmap -layout de &

/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets &

nextcloud &
