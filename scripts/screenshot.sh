#!/usr/bin/env bash

set -o pipefail

img_path=~/Images/latest_screenshot.png

if [ $XDG_SESSION_TYPE == "wayland" ]; then
    { if [ $# = 0 ]; then slurp | grim -g- -; else grim -; fi; } |
        tee $img_path |
        wl-copy -t image/png
else
    # TODO: write/yoink slop shader for blur
    maim -u$1 |
        tee $img_path |
        xclip -selection clipboard -t image/png
fi &&
    mv $img_path ~/Images/screenshots/$(date +%s).png &&
    notify-send -u low 'screenshot taken'
