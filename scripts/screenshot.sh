#!/usr/bin/env bash

set -o pipefail

img_path=$HOME/Images/latest_screenshot.png
linkmove() {
    mv -- "$1" "$2"
    ln -s -- "$2" "$1"
}

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    { if [ $# = 0 ]; then slurp | grim -g- -; else grim -; fi; } |
        tee "$img_path" | wl-copy -t image/png
else
    maim -u"$1" |
        tee "$img_path" | xclip -selection clipboard -t image/png
fi &&
    linkmove "$img_path" ~/Images/screenshots/"$(date +%s)".png &&
    notify-send -u low 'screenshot taken'
