#!/bin/bash

set -o pipefail

img_path=~/Images/latest_screenshot.png
{ if [ $# = 0 ]; then slurp | grim -g- -; else grim -; fi; } |
    tee $img_path |
    wl-copy -t image/png &&
    cp $img_path ~/Images/screenshots/$(date +%s).png &&
    notify-send -u low 'screenshot taken'
