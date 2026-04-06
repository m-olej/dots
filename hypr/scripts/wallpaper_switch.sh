#!/bin/bash

# Wallpaper directory
wallDIR="$HOME/Documents/wallpapers"
rofiDiR="$HOME/.config/rofi"

rofi="rofi -theme ${rofiDIR}/wallpaper.rasi"

# Get available monitors
monitors=($(hyprctl monitors | awk '/^Monitor/{print $2}'))

# Allow selecting a monitor
selected_monitor=$(printf "%s\n" "${monitors[@]}" | ${rofi} -dmenu -i -p "Select Monitor")

if [[ -z "$selected_monitor" ]]; then
    exit 1
fi

# Select wallpaper with preview
choice=$(find "${wallDIR}" -type f \( -iname \*.jpg -o -iname \*.jpeg -o -iname \*.png \) \
    | ${rofi} -dmenu -i -p "Select Wallpaper" \
    -theme-str 'window {width: 50%; height: 60%;}')

# Apply wallpaper if selected
if [[ -n "$choice" ]]; then

    hyprctl hyprpaper wallpaper "$selected_monitor,$choice,cover"
    
    notify-send "Wallpaper set on $selected_monitor"
fi
