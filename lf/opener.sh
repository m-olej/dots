#!/usr/bin/env bash

# Get the exact MIME type of the highlighted file
MIME=$(file --dereference --brief --mime-type "$1")

case "$MIME" in
    # If it is any kind of text or code, open it in Neovim in the current pane
    text/* | application/json | application/x-shellscript | application/javascript)
        nvim "$1"
        ;;
    # Open images in swayimg
    image/*)
        swayimg "$1" & disown
        ;;
    # Open videos in mpv, forcing GUI mode and native Wayland rendering
    video/* | audio/*)
        mpv --player-operation-mode=pseudo-gui --vo=gpu-next --hwdec=auto-safe "$1" & disown
        ;;
    # If it is a PDF, open it in zathura
    application/pdf)
        zathura "$1" & disown
        ;;
    # For everything else (web links, archives), fallback to the system default
    *)
        xdg-open "$1" & disown
        ;;
esac
