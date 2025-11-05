#!/bin/bash

# Lambda Calculus themed power menu for Waybar
# Standalone script - no external dependencies

DIR="$HOME/.config/waybar/scripts"

# Get system info
uptime=$(uptime -p | sed -e 's/up //g')
host=$(hostname)

# Power menu options
shutdown='⏻  Shutdown'
reboot='⟳  Reboot'
suspend='⏼  Suspend'
hibernate='⏾  Hibernate'
logout='⇠  Logout'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "$host" \
        -mesg "Uptime: $uptime" \
        -theme "$DIR/powermenu.rasi"
}

# Confirmation CMD
confirm_cmd() {
    rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 300px;}' \
        -theme-str 'mainbox {children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme "$DIR/powermenu.rasi"
}

# Ask for confirmation
confirm_exit() {
    echo -e "λ  Yes\n∅  No" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
    echo -e "$suspend\n$hibernate\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [[ "$selected" == "λ  Yes" ]]; then
        if [[ $1 == '--shutdown' ]]; then
            systemctl poweroff
        elif [[ $1 == '--reboot' ]]; then
            systemctl reboot
        elif [[ $1 == '--suspend' ]]; then
            systemctl suspend
        elif [[ $1 == '--hibernate' ]]; then
            systemctl hibernate
        elif [[ $1 == '--logout' ]]; then
            hyprctl dispatch exit
        fi
    else
        exit 0
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    "$shutdown")
        run_cmd --shutdown
        ;;
    "$reboot")
        run_cmd --reboot
        ;;
    "$suspend")
        run_cmd --suspend
        ;;
    "$hibernate")
        run_cmd --hibernate
        ;;
    "$logout")
        run_cmd --logout
        ;;
esac
