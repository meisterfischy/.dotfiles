xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144 --primary &
xrandr --output DisplayPort-1 --mode 1920x1080 --rate 60 --right-of DisplayPort-0 &
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60 --left-of DisplayPort-0 &
feh --bg-max Dokumente/Sync/Wallpaper/WeLostTheSea.png &
picom &
setxkbmap de &
ckb-next -b &

exec i3
