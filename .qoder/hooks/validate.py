#!/usr/bin/env python3
"""Validate Waybar files: strict JSON for `config`, bash syntax for *.sh.

Hook mode: reads tool JSON on stdin, validates the edited file.
Manual mode: validates each path given as an argument.
"""

import json
import os
import subprocess
import sys


def validate_file(path):
    if path.endswith(".sh"):
        result = subprocess.run(["bash", "-n", path], capture_output=True, text=True)
        if result.returncode != 0:
            sys.stderr.write(result.stderr)
            return False
    elif os.path.basename(path) == "config":
        try:
            with open(path) as f:
                json.load(f)
        except json.JSONDecodeError as e:
            sys.stderr.write("invalid JSON in {}: {}\n".format(path, e))
            return False
    return True


def main():
    paths = sys.argv[1:]
    if not paths:
        try:
            payload = json.load(sys.stdin)
        except ValueError:
            return 0
        response = payload.get("tool_response") or {}
        tool_input = payload.get("tool_input") or {}
        path = response.get("filePath") or tool_input.get("file_path") or ""
        if not path:
            return 0
        paths = [path]

    failed = [p for p in paths if os.path.isfile(p) and not validate_file(p)]
    return 2 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
