#xrandr --output DVI-D-0 --mode 1920x1080 --rate 144 --primary &
#xrandr --output DisplayPort-0 --mode 1920x1080 --rate 60 --right-of DVI-D-0 &
#xrandr --output HDMI-A-1 --mode 1920x1080 --rate 60 --left-of DVI-D-0 &
monitor &
#feh --bg-max Dokumente/Sync/Wallpaper/WeLostTheSea.png &
picom &
setxkbmap de &
ckb-next -b &

exec i3
