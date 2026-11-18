---
name: verify
description: Validate this Waybar config (strict JSON + bash syntax) and reload the running Waybar. Use after editing config, style.css, or scripts/, or when the bar misbehaves.
---

Validate the current working tree of this Waybar configuration and reload the live bar. This repo has no test suite; these checks are the closest equivalent.

## Steps

1. Run the validator and capture failures:

   ```bash
   python3 .qoder/hooks/validate.py config scripts/*.sh
   ```

   Exit code 0 means all files pass; exit code 2 means at least one failed, with the file and error printed to stderr.

2. If Waybar is running (`pgrep -x waybar`), reload it with `pkill -USR2 -x waybar`, then confirm it is still running. If it is not running, say so and do not launch it — it requires a live Wayland/niri session. (`killall` is not installed on this machine.)

3. `style.css` and the `.rasi` files cannot be validated non-interactively. If they changed, note that a visual check is required and that Waybar prints CSS errors to stderr on reload.

## Report

- One line per check: pass/fail.
- On failure, include the exact validator output (the JSON error reports line/column; the bash error reports the offending line) and the file to fix.
- If reload was skipped or failed, state why.
