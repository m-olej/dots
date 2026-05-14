#!/usr/bin/env bash

# 1. Get the ID of the first connected device
# (Using awk to safely strip away the "1 device found" text)
DEVICE_ID=$(kdeconnect-cli -a --id-only | awk '{print $1}' | head -n 1)

if [ -z "$DEVICE_ID" ]; then
    exit 0
fi

# 2. Fetch the battery charge and status directly from the D-Bus interface
BATTERY=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEVICE_ID/battery" org.kde.kdeconnect.device.battery.charge 2>/dev/null)
IS_CHARGING=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$DEVICE_ID/battery" org.kde.kdeconnect.device.battery.isCharging 2>/dev/null)

# 3. Format the Waybar output
ICON="📱"
if [ "$IS_CHARGING" == "true" ]; then
    ICON="⚡"
fi

# If battery data successfully returned, display it. Otherwise, fallback to 'Connected'
if [ -n "$BATTERY" ] && [ "$BATTERY" != "-1" ]; then
    echo '{"text": "'"$ICON"' '"$BATTERY"'%", "class": "connected", "percentage": '"$BATTERY"'}'
else
    echo '{"text": "📱 Connected", "class": "connected"}'
fi
