#!/usr/bin/env bash

# Catch termination signals and kill all child processes
trap 'pkill -P $$' EXIT SIGINT SIGTERM

PLAYER="--player=spotify_player"

# Infinite loop ensures the script reconnects if playerctl dies
while true; do
    # Listen to DBus events instead of polling
    playerctl $PLAYER metadata --format '{{status}}::{{artist}} - {{title}}::{{album}}' --follow 2>/dev/null | while read -r line; do
        
        # 1. Split variables using native bash (Zero subprocesses, lightning fast)
        STATUS="${line%%::*}"
        REMAINDER="${line#*::}"
        TEXT="${REMAINDER%%::*}"
        ALBUM="${REMAINDER#*::}"

        # 2. Truncate text if it's too long
        if [ ${#TEXT} -gt 45 ]; then
            TEXT="${TEXT:0:42}..."
        fi

        # 3. Use jq to safely construct the JSON and handle newlines correctly.
        if [[ "$STATUS" == "Playing" ]]; then
            jq -c -n --unbuffered --arg text "$TEXT" --arg album "$ALBUM" \
                '{"text": $text, "class": "playing", "tooltip": ($text + "\n " + $album)}'
        elif [[ "$STATUS" == "Paused" ]]; then
            jq -c -n --unbuffered --arg text "$TEXT" --arg album "$ALBUM" \
                '{"text": $text, "class": "paused", "tooltip": ("Paused\n" + $text + "\n " + $album)}'
        fi
        
    done

    # If the playerctl process dies, clear the module and wait
    echo '{"text": "", "class": "stopped", "tooltip": "Nothing Playing"}'
    sleep 5 # safety belt to prevent fast spinning
done
