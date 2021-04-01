xrandr --output DVI-D-0 --mode 1920x1080 --rate 144 --primary &
#xrandr --output DisplayPort-1 --mode 1920x1080 --rate 144 --primary &
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60 &
feh --bg-max Dokumente/Sync/Wallpaper/WeLostTheSea.png &
picom &

exec i3
