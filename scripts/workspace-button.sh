#!/usr/bin/env bash

# Lambda workspace button script for niri
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

# Function to generate output for this workspace
generate_output() {
    # Get focused workspace index (single fast call)
    local active
    active=$(niri msg -j workspaces 2>/dev/null | grep -oP '\{[^{}]*"idx":\K[0-9]+(?=[^{}]*"is_focused":true)')

    if [[ "$WS_ID" -eq "$active" ]]; then
        # Active workspace
        echo "{\"text\":\"${lambda[$WS_ID]}\", \"class\":\"active\"}"
    else
        # Inactive workspace - always show
        echo "{\"text\":\"${greek[$WS_ID]}\", \"class\":\"inactive\"}"
    fi
}

# Generate initial output
generate_output

# Listen to niri events for workspace changes
niri msg event-stream 2>/dev/null | while read -r line; do
    case "$line" in
        Workspace*)
            generate_output
            ;;
    esac
done

# Fallback to polling if the event stream ends (e.g. niri restarted)
while true; do
    sleep 2
    generate_output
done
