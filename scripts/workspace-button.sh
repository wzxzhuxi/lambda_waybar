#!/bin/bash

# Lambda workspace button script
# Usage: workspace-button.sh <workspace_id>
# Generates a single workspace button with proper styling

WS_ID=$1

declare -A greek=(
    [1]="α" [2]="β" [3]="γ" [4]="δ" [5]="ε"
    [6]="ζ" [7]="η" [8]="θ" [9]="ι" [10]="κ"
)

declare -A lambda=(
    [1]="λ₁" [2]="λ₂" [3]="λ₃" [4]="λ₄" [5]="λ₅"
    [6]="λ₆" [7]="λ₇" [8]="λ₈" [9]="λ₉" [10]="λ₁₀"
)

# Cache for reducing calls
LAST_ACTIVE=""

# Function to generate output for this workspace
generate_output() {
    # Get active workspace ID (single fast call)
    local active=$(hyprctl -j activeworkspace | grep -oP '(?<="id": )\d+')

    # Only update if active workspace changed
    if [ "$active" == "$LAST_ACTIVE" ] && [ "$WS_ID" -ne "$active" ]; then
        return
    fi
    LAST_ACTIVE="$active"

    if [ "$WS_ID" -eq "$active" ]; then
        # Active workspace
        echo "{\"text\":\"${lambda[$WS_ID]}\", \"class\":\"active\"}"
    else
        # Inactive workspace - always show
        echo "{\"text\":\"${greek[$WS_ID]}\", \"class\":\"inactive\"}"
    fi
}

# Generate initial output
generate_output

# Listen to Hyprland events
SOCKET="/run/user/1000/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"

if [ -S "$SOCKET" ]; then
    socat -u UNIX-CONNECT:"$SOCKET" - 2>/dev/null | while read -r line; do
        if [[ "$line" == workspace* ]] || [[ "$line" == createworkspace* ]] || [[ "$line" == destroyworkspace* ]]; then
            generate_output
        fi
    done
else
    # Fallback to polling
    while true; do
        sleep 2
        generate_output
    done
fi
