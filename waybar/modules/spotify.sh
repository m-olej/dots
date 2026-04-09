#!/usr/bin/env bash

# 1. Kill children and EXIT when Waybar sends a shutdown signal
trap 'pkill -P $$; exit 0' EXIT SIGINT SIGTERM

PLAYER="--player=molej,molej-spotify,spotify_player"

# Infinite loop ensures the script reconnects if playerctl dies
while true; do
    
    # 2. Process Substitution < <(...) prevents bash from spawning a duplicate subshell
    while read -r line; do
        
        # Split variables using native bash
        STATUS="${line%%::*}"
        REMAINDER="${line#*::}"
        TEXT="${REMAINDER%%::*}"
        ALBUM="${REMAINDER#*::}"

        # Truncate text if it's too long
        if [ ${#TEXT} -gt 45 ]; then
            TEXT="${TEXT:0:42}..."
        fi

        # Use jq to safely construct the JSON
        if [[ "$STATUS" == "Playing" ]]; then
            jq -c -n --unbuffered --arg text "$TEXT" --arg album "$ALBUM" \
                '{"text": $text, "class": "playing", "tooltip": ($text + "\n " + $album)}'
        elif [[ "$STATUS" == "Paused" ]]; then
            jq -c -n --unbuffered --arg text "$TEXT" --arg album "$ALBUM" \
                '{"text": $text, "class": "paused", "tooltip": ("Paused\n" + $text + "\n" + $album)}'
        fi
        
    done < <(playerctl $PLAYER metadata --format '{{status}}::{{artist}} - {{title}}::{{album}}' --follow 2>/dev/null)

    # If the playerctl process dies, clear the module and wait
    echo '{"text": "", "class": "stopped", "tooltip": "Nothing Playing"}'
    sleep 5
done
