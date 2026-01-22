#!/bin/bash

# Powermenu script for Hyprland with rofi

# Options
shutdown="  Shutdown"
reboot="  Reboot"
lock="  Lock"
suspend="  Suspend"
logout="  Logout"

# Rofi command
rofi_cmd() {
    rofi -dmenu \
        -p "Power" \
        -mesg "Power Menu" \
        -theme ~/.config/rofi/themes/hacker-green.rasi
}

# Pass options to rofi
run_rofi() {
    echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute command
case "$(run_rofi)" in
    "$shutdown")
        systemctl poweroff
        ;;
    "$reboot")
        systemctl reboot
        ;;
    "$lock")
        hyprlock || swaylock -f -c 000000
        ;;
    "$suspend")
        systemctl suspend
        ;;
    "$logout")
        hyprctl dispatch exit
        ;;
esac
