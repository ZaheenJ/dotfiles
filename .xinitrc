xrandr --setprovideroutputsource NVIDIA-G0 modesetting 
# xrandr --setprovideroffloadsink NVIDIA-G0 modesetting 
xrandr --auto
autorandr -c
# nvidia-force-comp-pipeline
~/.fehbg &
picom -b --experimental-backends &
xset r rate 200 50 &
# noisetorch -i &
flameshot &
setxkbmap -option caps:swapescape -variant altgr-intl &
dbus-launch dwm
