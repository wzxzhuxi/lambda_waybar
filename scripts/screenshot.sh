#!/usr/bin/env bash

# Screenshot menu for Waybar
# Using grim and slurp for Wayland screenshots

# Check if required tools are installed
if ! command -v grim &> /dev/null; then
    notify-send "Σ Screenshot" "grim is not installed" -u critical
    exit 1
fi

if ! command -v wl-copy &> /dev/null; then
    notify-send "Σ Screenshot" "wl-clipboard is not installed" -u critical
    exit 1
fi

# Show menu using rofi with custom theme
choice=$(echo -e "⊡ Full Screen\n⊞ Select Area\n⊟ Current Window" | rofi -dmenu -p "Σ Screenshot" -theme ~/.config/waybar/scripts/screenshot-menu.rasi 2>/dev/null)

# Screenshot directory
screenshot_dir="$HOME/Pictures/Screenshots"
mkdir -p "$screenshot_dir"

# Timestamp for filename (format: Screenshot_YYYYMMDD_HHMMSS.png)
timestamp=$(date +%Y%m%d_%H%M%S)
filename="$screenshot_dir/Screenshot_$timestamp.png"

case "$choice" in
    "⊡ Full Screen")
        grim "$filename"
        if [ $? -eq 0 ]; then
            wl-copy < "$filename"
            notify-send "Σ Screenshot" "Full screen saved and copied to clipboard" -i "$filename"
        fi
        ;;
    "⊞ Select Area")
        if command -v slurp &> /dev/null; then
            grim -g "$(slurp)" "$filename"
            if [ $? -eq 0 ]; then
                wl-copy < "$filename"
                notify-send "Σ Screenshot" "Area screenshot saved and copied to clipboard" -i "$filename"
            fi
        else
            notify-send "Σ Screenshot" "slurp is not installed" -u critical
        fi
        ;;
    "⊟ Current Window")
        if command -v niri &> /dev/null; then
            niri msg action screenshot-window
            if [ $? -eq 0 ]; then
                notify-send "Σ Screenshot" "Window screenshot saved and copied to clipboard"
            else
                notify-send "Σ Screenshot" "Window screenshot failed (no focused window?)" -u critical
            fi
        else
            notify-send "Σ Screenshot" "niri is not available" -u critical
        fi
        ;;
    *)
        exit 0
        ;;
esac
