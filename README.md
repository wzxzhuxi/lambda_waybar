# Waybar Configuration - Lambda Calculus Theme

A beautiful Waybar configuration for Hyprland with lambda calculus inspired design and Gruvbox Dark color scheme.

[中文文档](./README_CN.md)

## Screenshots

- Bottom bar with custom workspace indicators
- MPRIS media player with audio visualizer
- System information with lambda symbols
- Custom screenshot and power menus

## Features

### 🎨 Design
- **Theme**: Gruvbox Dark color palette
- **Style**: Lambda calculus inspired symbols (λ, τ, Σ, ∅, etc.)
- **Font**: JetBrains Mono Nerd Font (recommended)
- **Position**: Bottom bar

### 📊 Components

**Left Side:**
- Custom workspace indicators (λ1 - λ10)
- MPRIS media player (μ/π symbols)
- Real-time audio visualizer (cava)

**Center:**
- Current focused window title

**Right Side:**
- Audio volume (α)
- Network status (φ/η/χ)
- CPU usage (ψ)
- Memory usage (ω)
- Battery status (β)
- Clock (τ)
- Screenshot tool (Σ)
- System tray
- Power menu (∅)

### ⚡ Functionality

**Screenshot (Σ):**
- Left click: Quick area selection (fastest workflow)
- Right click: Full menu (Full screen / Select area / Current window)
- Screenshots are saved as PNG format
- Filename format: `Screenshot_YYYYMMDD_HHMMSS.png`
- Automatically saved to: `~/Pictures/Screenshots/`
- Automatically copied to clipboard (use Ctrl+V to paste)

**Media Player (MPRIS):**
- Click: Play/pause
- Scroll up: Next track
- Scroll down: Previous track
- Shows inspirational message when no media is playing

**System Components:**
- Click on any component to open relevant configuration tool

## Dependencies

### Required
```bash
# Core
waybar playerctl hyprctl

# Screenshot
grim slurp rofi wl-clipboard

# Audio visualizer
cava

# System tools
pavucontrol nmtui htop jq notify-send
```

### Font
```bash
# Arch Linux
sudo pacman -S ttf-jetbrains-mono-nerd

# Or install from: https://www.nerdfonts.com/
```

## Installation

1. Backup your existing waybar config:
```bash
mv ~/.config/waybar ~/.config/waybar.backup
```

2. Copy this configuration:
```bash
cp -r /path/to/this/waybar ~/.config/
```

3. Install dependencies:
```bash
sudo pacman -S waybar playerctl grim slurp rofi cava \
               wl-clipboard pavucontrol nmtui htop jq \
               libnotify ttf-jetbrains-mono-nerd
```

4. Restart Waybar:
```bash
killall waybar && waybar &
```

## File Structure

```
~/.config/waybar/
├── config                    # Main configuration
├── style.css                 # CSS styling
├── cava-waybar.config        # Audio visualizer config
└── scripts/
    ├── cava-output.sh        # Audio visualizer output
    ├── powermenu.sh          # Power menu
    ├── powermenu.rasi        # Power menu theme
    ├── screenshot.sh         # Screenshot menu
    ├── screenshot-area.sh    # Quick area screenshot
    ├── screenshot-menu.rasi  # Screenshot menu theme
    └── workspace-button.sh   # Workspace indicators
```

## Customization

### Change Colors
Edit `style.css` to modify Gruvbox colors:
- Background: `#282828`
- Foreground: `#ebdbb2`
- Accent colors: `#98971a` (green), `#d79921` (yellow), `#458588` (blue)

### Adjust Components
Edit `config` file:
- Modify `modules-left`, `modules-center`, `modules-right` to rearrange components
- Change symbols in format strings
- Adjust update intervals

### Lambda Symbols Used
- λ (lambda) - Workspace numbers
- τ (tau) - Clock
- Σ (Sigma) - Screenshot
- ∅ (emptyset) - Power
- μ (mu) - Media playing
- π (pi) - Media paused
- ε (epsilon) - Media stopped (shows: "May your life bloom like a flower")
- α (alpha) - Audio volume
- φ (phi) - WiFi
- η (eta) - Ethernet
- χ (chi) - Network disconnected
- ψ (psi) - CPU usage
- ω (omega) - Memory usage
- β (beta) - Battery (β⁺ charging, β∞ plugged)

## Troubleshooting

**Symbols not displaying correctly:**
- Install JetBrains Mono Nerd Font
- Restart Waybar after font installation

**Screenshot not working:**
- Install `grim`, `slurp`, and `wl-clipboard`
- For window screenshots, install `jq`
- Check notification: "Screenshot saved and copied to clipboard"

**Audio visualizer not showing:**
- Install `cava`
- Check PipeWire is running

**Media player not working:**
- Install `playerctl`
- Ensure your media player supports MPRIS

## Credits

- Theme: Gruvbox Dark by morhetz
- Inspired by: Lambda calculus and functional programming
- Built for: Hyprland on Arch Linux

## License

MIT License - Feel free to use and modify
