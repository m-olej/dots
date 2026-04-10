#!/usr/bin/env bash

# Kill children and EXIT when Waybar sends a shutdown signal
trap 'pkill -P $$; exit 0' EXIT SIGINT SIGTERM

PLAYER="--player=spotify_player,spotify"

# Infinite loop ensures the script reconnects if playerctl dies
while true; do
    
    # Process Substitution prevents subshell spawning
    while read -r line; do
        
        # 1. If output contains \n the line is split in two. Ignore each line after \n 
        if [[ "$line" != Playing::* && "$line" != Paused::* && "$line" != Stopped::* ]]; then
            continue
        fi

        # 2. Split variables
        STATUS="${line%%::*}"
        REMAINDER="${line#*::}"
        TEXT="${REMAINDER%%::*}"
        ALBUM="${REMAINDER#*::}"

        # 3. CLEANUP: Strip dangling dashes and invisible whitespace
        TEXT=$(echo "$TEXT" | sed 's/^[[:space:]-]*//; s/[[:space:]-]*$//')
        ALBUM=$(echo "$ALBUM" | sed 's/^[[:space:]-]*//; s/[[:space:]-]*$//')

        # 4. Handle "Stopped" or empty status gracefully
        if [[ "$STATUS" == "Stopped" || -z "$STATUS" ]]; then
            echo '{"text": "", "class": "stopped", "tooltip": "Nothing Playing"}'
            continue
        fi

        # 5. Failsafe to prevent the module from completely vanishing
        if [[ -z "$TEXT" ]]; then
            TEXT="Spotify"
        fi

        # 6. Truncate text before it shoves other Waybar modules off the screen
        if [ ${#TEXT} -gt 45 ]; then
            TEXT="${TEXT:0:42}..."
        fi

        # 7. Only add the \n and the Album icon if an album actually exists!
        if [[ -n "$ALBUM" ]]; then
            TOOLTIP="$TEXT
               $ALBUM"
        else
            TOOLTIP="$TEXT"
        fi

        # 8. Output safe JSON via jq
        if [[ "$STATUS" == "Playing" ]]; then
            jq -c -n --unbuffered --arg text "$TEXT" --arg tt "$TOOLTIP" \
                '{"text": $text, "class": "playing", "tooltip": $tt}'
        elif [[ "$STATUS" == "Paused" ]]; then
            jq -c -n --unbuffered --arg text "$TEXT" --arg tt "Paused\n$TOOLTIP" \
                '{"text": $text, "class": "paused", "tooltip": $tt}'
        fi
        
    done < <(playerctl $PLAYER metadata --format '{{status}}::{{artist}} - {{title}}::{{album}}' --follow 2>/dev/null)

    # If the playerctl process dies, clear the module and wait 5 seconds
    echo '{"text": "", "class": "stopped", "tooltip": "Nothing Playing"}'
    sleep 5
done
