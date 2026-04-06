#!/usr/bin/env bash

# State tracking to prevent notification spam
WARNING_SENT=false
CRITICAL_SENT=false

while true; do
    # Grab the current battery percentage and charging status
    BATTERY=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
    STATUS=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)
    
    # Ensure variables aren't empty (e.g., if on a desktop)
    if [[ -z "$BATTERY" || -z "$STATUS" ]]; then
        exit 0
    fi

    if [[ "$STATUS" == "Discharging" ]]; then
        # Critical Alert (10% or lower)
        if [[ "$BATTERY" -le 10 && "$CRITICAL_SENT" == false ]]; then
            notify-send "Battery Critical" "Only ${BATTERY}% remaining! Plug in immediately." \
                -u critical -i battery-empty -t 10000
            CRITICAL_SENT=true
            
        # Warning Alert (20% or lower)
        elif [[ "$BATTERY" -le 20 && "$BATTERY" -gt 10 && "$WARNING_SENT" == false ]]; then
            notify-send "Battery Low" "Down to ${BATTERY}%. Consider plugging in soon." \
                -u normal -i battery-caution -t 5000
            WARNING_SENT=true
        fi
    else
        # If the laptop is plugged in ("Charging" or "Full"), reset the trackers
        WARNING_SENT=false
        CRITICAL_SENT=false
    fi
    
    # Check again in 60 seconds
    sleep 60
done
