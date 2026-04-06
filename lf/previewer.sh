#!/bin/sh

file="$1"
w="$2"
h="$3"
x="$4"
y="$5"

# Detect the file type
mime=$(file -Lb --mime-type "$file")

case "$mime" in
    image/*)
        # Check if our toggle file exists
        if [ -f "$HOME/.cache/lf_image_toggle" ]; then
            kitty +kitten icat --silent --stdin no --transfer-mode file --place "${w}x${h}@${x}x${y}" "$file" < /dev/null > /dev/tty
            exit 1
        else
            # What to show when the image is NOT rendering
            echo "🖼️  Image File"
            echo "Press 'i' to render image preview"
            echo "-----------------------------------"
            file -Lb "$file"
        fi
        ;;
    text/* | application/json | inode/x-empty)
        # Use bat for syntax highlighting
        bat --color=always --style=numbers --terminal-width="$w" "$file"
        ;;
    *)
        # Fallback for unknown files (just prints the file info)
        file -Lb "$file"
        ;;
esac
