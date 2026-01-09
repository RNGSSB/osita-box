#!/bin/sh
printf '\033c\033]0;%s\a' osita-box
base_path="$(dirname "$(realpath "$0")")"
"$base_path/osita-box.x86_64" "$@"
