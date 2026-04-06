#!/usr/bin/zsh

# --- CONFIGURATION ---
CLIPHIST_CMD="/usr/bin/cliphist"
ROFI_CMD="/usr/bin/rofi"
WL_COPY_CMD="/usr/bin/wl-copy"
export XDG_CACHE_HOME="$HOME/.cache"

dir="$HOME/.config/rofi"
theme="clipboard"

# --- EXECUTION ---
"$CLIPHIST_CMD" list | \
    "$ROFI_CMD" -dmenu -theme "${dir}/${theme}.rasi" -p "Copy" | \
    "$CLIPHIST_CMD" decode | \
    "$WL_COPY_CMD"
