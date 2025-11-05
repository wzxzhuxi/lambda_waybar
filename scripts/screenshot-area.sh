#!/bin/bash

# Quick area screenshot for Waybar

# Check if required tools are installed
if ! command -v grim &> /dev/null; then
    notify-send "Σ Screenshot" "grim is not installed" -u critical
    exit 1
fi

if ! command -v slurp &> /dev/null; then
    notify-send "Σ Screenshot" "slurp is not installed" -u critical
    exit 1
fi

if ! command -v wl-copy &> /dev/null; then
    notify-send "Σ Screenshot" "wl-clipboard is not installed" -u critical
    exit 1
fi

# Screenshot directory
screenshot_dir="$HOME/Pictures/Screenshots"
mkdir -p "$screenshot_dir"

# Timestamp for filename (format: Screenshot_YYYYMMDD_HHMMSS.png)
timestamp=$(date +%Y%m%d_%H%M%S)
filename="$screenshot_dir/Screenshot_$timestamp.png"

# Take area screenshot and save to both file and clipboard
grim -g "$(slurp)" "$filename"

if [ $? -eq 0 ]; then
    # Copy to clipboard
    wl-copy < "$filename"
    notify-send "Σ Screenshot" "Screenshot saved and copied to clipboard" -i "$filename"
else
    notify-send "Σ Screenshot" "Screenshot cancelled" -u low
fi
