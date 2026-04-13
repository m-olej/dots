#!/usr/bin/env bash

# Target the primary Asus touchpad
TOUCHPAD="asup1204:00-093a:2642-touchpad"

# Force a quick off/on cycle
hyprctl keyword device:$TOUCHPAD:enabled false
sleep 0.5
hyprctl keyword device:$TOUCHPAD:enabled true
