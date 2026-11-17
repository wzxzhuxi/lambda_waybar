---
name: add-workspace
description: Add or remove a numbered workspace button consistently across config, style.css, and scripts/workspace-button.sh. Use when changing the number of workspace modules (e.g. adding ws11 or removing ws10).
---

Workspace buttons are duplicated in three places. Change all of them in numeric order, then validate.

## Add workspace N (e.g. `/add-workspace 11`)

1. `config` — add the module definition after the last `custom/ws*` block, following the existing template exactly:

   ```json
   "custom/wsN": {
       "exec": "~/.config/waybar/scripts/workspace-button.sh N",
       "return-type": "json",
       "format": "{}",
       "on-click": "niri msg action focus-workspace N"
   },
   ```

   Also append `"custom/wsN"` to the `modules-left` array after the last workspace entry.

2. `style.css` — add `#custom-wsN` (as `#custom-wsN,` or the final `#custom-wsN`) at the end of each of the three selector groups: base (`#custom-ws1,` …), `.hidden`, and `.active`.

3. `scripts/workspace-button.sh` — add entries to both associative arrays: `greek` and `lambda`. Subscript digits for the lambda map use Unicode subscripts (e.g. 11 → `λ₁₁`). The `greek` map has single letters only for 1–10 (`α β γ δ ε ζ η θ ι κ`); for N > 10, ask the user which glyph to use instead of inventing one.

4. Validate: `python3 .qoder/hooks/validate.py config scripts/workspace-button.sh`, then reload with `killall -SIGUSR2 waybar` if it is running.

## Remove workspace N

1. Remove the `custom/wsN` block from `config` and its entry in `modules-left`.
2. Remove `#custom-wsN` from all three selector groups in `style.css`.
3. Remove key `N` from the `greek` and `lambda` maps in `scripts/workspace-button.sh`.
4. Validate and reload as above.

Do not renumber remaining workspaces unless asked; gaps are fine.
