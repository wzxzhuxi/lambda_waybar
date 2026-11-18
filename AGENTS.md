# AGENTS.md

This file provides guidance to the AI agent when working with code in this repository.

## What this is

A Waybar + niri (Wayland-only) status bar configuration: `config` (Waybar JSON, must stay named exactly `config`), `style.css` (GTK CSS), `scripts/*.sh`, rofi `.rasi` themes, and `cava-waybar.config`. This `niri` branch is a port of the original Hyprland setup on `main`. No build system, package manager, tests, lint, or format config. On the author's machine this repo is symlinked to `~/.config/waybar`, so edits go live after a Waybar reload.

## Gotchas

- All `exec`/`on-click` commands in `config` and all script paths hardcode `~/.config/waybar/...`. Keep those absolute user paths; do not convert them to relative paths.
- Workspaces use Waybar's built-in `niri/workspaces` module: index-keyed `format-icons` in `config`, styled via the `#workspaces button` rules in `style.css`. There are no per-workspace scripts or selectors; do not reintroduce `custom/wsN` modules.
- Do not add `focused`/`active`/`empty`/`urgent` keys to the workspaces `format-icons`: state icons take precedence over index icons and would replace the Greek glyphs. The active state is highlighted by CSS instead.
- niri workspace indices are positions on the focused monitor, and the module only shows existing workspaces, so the button count changes dynamically.
- `config` is strict JSON: no comments, no trailing commas.
- Window screenshots use `niri msg action screenshot-window` (niri saves to `~/Pictures/Screenshots` and copies to the clipboard); full-screen and area shots use `grim` + `slurp`.
- The Greek/lambda glyphs are the theme; JetBrains Mono Nerd Font is required. Do not substitute ASCII symbols.
- `README.md` and `README_CN.md` are full translations of each other; keep them in sync.

## Conventions

- 4-space indentation in every file type. Bash scripts use `#!/usr/bin/env bash` and `# Section - description` header comments. `.rasi` property values are column-aligned.
- Validate (there are no tests): `python3 .qoder/hooks/validate.py config scripts/*.sh` — checks strict JSON and bash syntax; it also runs automatically after every Write/Edit via `.qoder/settings.json`.
- Reload the running bar after edits: `pkill -USR2 -x waybar` (full restart: `pkill -x waybar; waybar &`). `killall` is not installed on NixOS.
- Commit directly to the current branch (no PR flow); English conventional-commit-style messages, e.g. `docs: ...` with a short bullet body.
