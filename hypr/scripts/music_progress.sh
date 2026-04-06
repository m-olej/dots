#!/usr/bin/env bash

# Target spotify_player first, fallback to official spotify
PLAYER="--player=spotify_player,spotify"
STATUS=$(playerctl $PLAYER status 2>/dev/null)

# If nothing is playing or paused, exit silently to hide the widget
if [[ "$STATUS" != "Playing" && "$STATUS" != "Paused" ]]; then
    exit 0
fi

case "$1" in
    title)
        TITLE=$(playerctl $PLAYER metadata title 2>/dev/null)
        # Truncate if too long so it doesn't break symmetry
        if [ ${#TITLE} -gt 35 ]; then
            echo "${TITLE:0:32}..."
        else
            echo "$TITLE"
        fi
        ;;
    artist)
        playerctl $PLAYER metadata artist 2>/dev/null
        ;;
    progress)
        LENGTH=$(playerctl $PLAYER metadata mpris:length 2>/dev/null)
        POS=$(playerctl $PLAYER position 2>/dev/null)

        if [[ -z "$LENGTH" || -z "$POS" || "$LENGTH" == "0" ]]; then
            exit 0
        fi

        # Convert to seconds
        LEN_SEC=$(( LENGTH / 1000000 ))
        POS_SEC=$(printf "%.0f" "$POS")

        # Format to MM:SS
        FORMAT_LEN=$(printf "%d:%02d" $((LEN_SEC/60)) $((LEN_SEC%60)))
        FORMAT_POS=$(printf "%d:%02d" $((POS_SEC/60)) $((POS_SEC%60)))

        # Calculate progress bar steps (20 characters wide)
        BAR_LEN=20
        PROGRESS=$(( POS_SEC * BAR_LEN / LEN_SEC ))

        BAR=""
        for ((i=0; i<BAR_LEN; i++)); do
            if [ $i -lt $PROGRESS ]; then 
                BAR+="<span foreground='#C2D94C'>━</span>" # Green played
            elif [ $i -eq $PROGRESS ]; then 
                BAR+="<span foreground='#FFFFFF'></span>"  # White handle (Nerd Font Circle)
            else 
                BAR+="<span foreground='#303640'>━</span>" # Dark gray unplayed
            fi
        done

        # Output the full string with monospace font for perfect alignment
        echo "<span font_family='JetBrains Mono Nerd Font' font_weight='bold' foreground='#B3B1AD'>$FORMAT_POS $BAR $FORMAT_LEN</span>"
        ;;
    art)
        ART_URL=$(playerctl $PLAYER metadata mpris:artUrl 2>/dev/null)
        if [[ -z "$ART_URL" ]]; then exit 0; fi

        # If it's a web URL (Spotify), download it to a temp file
        if [[ "$ART_URL" == http* ]]; then
            TMP_ART="/tmp/spotify_art.png"
            CURRENT_URL=$(cat /tmp/spotify_art_url 2>/dev/null)

            # Only download if the song changed to save bandwidth/CPU
            if [[ "$ART_URL" != "$CURRENT_URL" ]]; then
                curl -s "$ART_URL" -o "$TMP_ART"
                echo "$ART_URL" > /tmp/spotify_art_url
            fi
            echo "$TMP_ART"
        # If it's a local file, just pass the path
        elif [[ "$ART_URL" == file://* ]]; then
            echo "${ART_URL#file://}"
        fi
        ;;
esac
