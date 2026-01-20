#!/bin/bash

# Detect password managers and exclude their clipboard operations
EXCLUDED_CLASSES="Bitwarden|KeePassXC|1Password|LastPass|NordPass"

# Check if the focused window is a password manager
ACTIVE_WINDOW=$(hyprctl activewindow -j | jq -r '.class')

if echo "$ACTIVE_WINDOW" | grep -qE "$EXCLUDED_CLASSES"; then
    # Copy without storing in history
    wl-copy --clear
    wl-paste | wl-copy --clear
else
    # Normal copy with history
    wl-paste --type text --watch cliphist store &
fi
