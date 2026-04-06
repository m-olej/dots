#!/usr/bin/env bash

# Target spotify_player first, fallback to standard spotify
PLAYER="--player=spotify_player,spotify"

# Infinite loop ensures the script reconnects if you restart the background daemon
while true; do
    # Listen to DBus events instead of polling (Saves battery/CPU)
    playerctl $PLAYER metadata --format '{{status}}::{{artist}} - {{title}}::{{album}}' --follow 2>/dev/null | while read -r line; do

        # Split the output into variables
        STATUS=$(echo "$line" | awk -F'::' '{print $1}')
        TEXT=$(echo "$line" | awk -F'::' '{print $2}')
        ALBUM=$(echo "$line" | awk -F'::' '{print $3}')

        # Truncate text if it's too long to prevent Waybar from stretching
        if [ ${#TEXT} -gt 45 ]; then
            TEXT="${TEXT:0:42}..."
        fi

        # Escape quotes to prevent invalid JSON
        TEXT="${TEXT//\"/\\\"}"
        ALBUM="${ALBUM//\"/\\\"}"

        # Output formatted JSON based on playback state
        if [[ "$STATUS" == "Playing" ]]; then
            echo "{\"text\": \"$TEXT\", \"class\": \"playing\", \"tooltip\": \"$TEXT\n $ALBUM\"}"
        elif [[ "$STATUS" == "Paused" ]]; then
            echo "{\"text\": \"$TEXT\", \"class\": \"paused\", \"tooltip\": \"Paused\n$TEXT\n $ALBUM\"}"
        fi

        # Flush output so Waybar updates instantly
        echo "" > /dev/null
    done

    # If the playerctl process dies (daemon stops), clear the module and wait
    echo '{"text": "", "class": "stopped", "tooltip": "Nothing Playing"}'
    sleep 2
done
