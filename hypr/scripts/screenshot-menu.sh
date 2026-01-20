#!/bin/bash

# Screenshot menu with wofi
# Save as ~/.config/hypr/scripts/screenshot-menu.sh

OPTIONS="🖥️ Fullscreen\n🪟 Active Window\n📐 Select Region\n✏️ Edit Region\n⚡ Quick Capture"

CHOICE=$(echo -e "$OPTIONS" | wofi --dmenu --prompt "Screenshot:" --width 300 --height 250)

case $CHOICE in
    "🖥️ Fullscreen")
        ~/.config/hypr/scripts/screenshot.sh fullscreen
        ;;
    "🪟 Active Window")
        ~/.config/hypr/scripts/screenshot.sh window
        ;;
    "📐 Select Region")
        ~/.config/hypr/scripts/screenshot.sh region
        ;;
    "✏️ Edit Region")
        ~/.config/hypr/scripts/screenshot.sh edit
        ;;
    "⚡ Quick Capture")
        ~/.config/hypr/scripts/screenshot.sh quick
        ;;
esac
