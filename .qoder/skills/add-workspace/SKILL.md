---
name: add-workspace
description: Add, change, or remove a workspace glyph in the Waybar niri/workspaces module. Use when changing which workspace indices are shown or which Greek letters represent them.
---

Workspaces are rendered by Waybar's built-in `niri/workspaces` module. There are no per-workspace scripts or CSS selectors.

## Change or add workspace N

1. In `config`, edit the `niri/workspaces` → `format-icons` object: adjust or add `"N": "<glyph>"`. Indices 1–10 use `α β γ δ ε ζ η θ ι κ`; keep numeric order.
2. Validate: `python3 .qoder/hooks/validate.py config`.
3. Reload: `pkill -USR2 -x waybar` (if Waybar is running).

## Remove workspace N

1. Delete key `"N"` from `format-icons` in `config`.
2. Validate and reload as above.

## Notes

- Keys are workspace indices (for unnamed workspaces) or workspace names. The module shows only existing workspaces, so the bar's button count is dynamic.
- Do not add `focused`/`active`/`empty`/`urgent` keys: Waybar checks state icons before index icons, so they would replace the Greek glyphs. The active state is highlighted by CSS (`#workspaces button.focused, #workspaces button.active`).
- For N > 10, ask the user which glyph to use; only 1–10 are themed.
