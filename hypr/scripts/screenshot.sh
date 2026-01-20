#!/bin/bash

# Screenshot script for Hyprland
# Usage: screenshot.sh [fullscreen|window|region|edit]

SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOTS_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="$SCREENSHOTS_DIR/screenshot_$TIMESTAMP.png"

case $1 in
    "fullscreen")
        grim "$FILENAME"
        wl-copy < "$FILENAME"
        notify-send "Screenshot" "Fullscreen captured: $FILENAME" -t 3000
        ;;
    "window")
        grim -g "$(hyprctl activewindow | grep "at:" | cut -d' ' -f2 | tr ',' ' ' | xargs -I{} echo {}),$(hyprctl activewindow | grep "size:" | cut -d' ' -f2 | tr ',' ' ')" "$FILENAME"
        wl-copy < "$FILENAME"
        notify-send "Screenshot" "Window captured: $FILENAME" -t 3000
        ;;
    "region")
        REGION=$(slurp)
        if [ -n "$REGION" ]; then
            grim -g "$REGION" "$FILENAME"
            wl-copy < "$FILENAME"
            notify-send "Screenshot" "Region captured: $FILENAME" -t 3000
        fi
        ;;
    "edit")
        REGION=$(slurp)
        if [ -n "$REGION" ]; then
            grim -g "$REGION" - | swappy -f - -o "$FILENAME"
            wl-copy < "$FILENAME"
            notify-send "Screenshot" "Screenshot edited and saved: $FILENAME" -t 3000
        fi
        ;;
    "quick")
        # Quick capture to clipboard only
        REGION=$(slurp)
        if [ -n "$REGION" ]; then
            grim -g "$REGION" - | wl-copy
            notify-send "Screenshot" "Quick capture copied to clipboard" -t 2000
        fi
        ;;
    *)
        echo "Usage: $0 {fullscreen|window|region|edit|quick}"
        exit 1
        ;;
esac
