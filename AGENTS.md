# AGENTS.md

This file provides guidance to the AI agent when working with code in this repository.

## What this is

A Waybar + niri (Wayland-only) status bar configuration: `config` (Waybar JSON, must stay named exactly `config`), `style.css` (GTK CSS), `scripts/*.sh`, rofi `.rasi` themes, and `cava-waybar.config`. This `niri` branch is a port of the original Hyprland setup on `main`. No build system, package manager, tests, lint, or format config. On the author's machine this repo is symlinked to `~/.config/waybar`, so edits go live after a Waybar reload.

## Gotchas

- All `exec`/`on-click` commands in `config` and all script paths hardcode `~/.config/waybar/...`. Keep those absolute user paths; do not convert them to relative paths.
- Workspace UI is duplicated 10 times: `custom/ws1`–`custom/ws10` in `config`, `#custom-wsN` selectors in three groups in `style.css`, and the `greek`/`lambda` maps in `scripts/workspace-button.sh`. Replicate any workspace change across all of them, in numeric order.
- `config` is strict JSON: no comments, no trailing commas.
- `scripts/workspace-button.sh` reads the focused workspace from `niri msg -j workspaces` and follows changes via `niri msg event-stream`, falling back to 2-second polling. It requires a running niri; it no longer uses socat or a hardcoded socket path.
- niri workspace indices are positions on the focused monitor, not stable IDs: `niri msg action focus-workspace N` focuses the Nth workspace (creating it if needed). Keep the 10 `on-click` commands and the script's maps in agreement.
- Window screenshots use `niri msg action screenshot-window` (niri saves to `~/Pictures/Screenshots` and copies to the clipboard); full-screen and area shots use `grim` + `slurp`.
- The Greek/lambda glyphs are the theme; JetBrains Mono Nerd Font is required. Do not substitute ASCII symbols.
- `README.md` and `README_CN.md` are full translations of each other; keep them in sync.

## Conventions

- 4-space indentation in every file type. Bash scripts use `#!/usr/bin/env bash` and `# Section - description` header comments. `.rasi` property values are column-aligned.
- Validate (there are no tests): `python3 .qoder/hooks/validate.py config scripts/*.sh` — checks strict JSON and bash syntax; it also runs automatically after every Write/Edit via `.qoder/settings.json`.
- Reload the running bar after edits: `killall -SIGUSR2 waybar` (full restart: `killall waybar && waybar &`).
- Commit directly to `main` (no feature branches/PRs); English conventional-commit-style messages, e.g. `docs: ...` with a short bullet body.
