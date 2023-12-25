#!/usr/bin/env bash

set -o pipefail

img_dir="${XDG_PICTURES_DIR-$HOME/images}"
img_path="${img_dir}/latest_screenshot.png"
tmp_path=/tmp/screenshot.png
linkmove() {
    mv -- "$1" "$2"
    ln -s -- "$2" "$1"
}

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    { if [ $# = 0 ]; then slurp | grim -g- -; else grim -; fi; } |
        tee $tmp_path | wl-copy -t image/png
else
    maim -u"$1" |
        tee $tmp_path | xclip -selection clipboard -t image/png
fi &&
    mv $tmp_path "$img_path" &&
    linkmove "$img_path" "$img_dir/screenshots/$(date +%s).png" &&
    notify-send -u low 'screenshot taken'
