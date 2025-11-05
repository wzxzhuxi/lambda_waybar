#!/bin/bash

# Convert cava output to Unicode bars for Waybar
bars=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

cava -p ~/.config/waybar/cava-waybar.config 2>/dev/null | while read -r line; do
    output=""
    for value in $line; do
        # Map value (0-7) to bar character
        if [[ "$value" =~ ^[0-9]+$ ]]; then
            idx=$((value > 7 ? 7 : value))
            output="${output}${bars[$idx]}"
        fi
    done
    [ -n "$output" ] && echo "$output"
done
