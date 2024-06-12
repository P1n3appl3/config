#!/usr/bin/env bash

set -o pipefail

img_dir="${XDG_PICTURES_DIR-$HOME/images}"
img_path="${img_dir}/latest_screenshot.png"
tmp_path=/tmp/screenshot.png
linkmove() {
    mv -- "$1" "$2"
    ln -sf -- "$2" "$3"
}

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    { if [ $# = 1 ]; then slurp | grim -g- -; else grim -; fi; } |
        tee $tmp_path | wl-copy -t image/png
else
    maim -u"$1" |
        tee $tmp_path | xclip -selection clipboard -t image/png
fi &&
    linkmove "$tmp_path" "$img_dir/screenshots/$(date +%s).png" "$img_path" &&
    notify-send -u low -a screenshot -i monitor -h int:transient:1 'screenshot taken'
