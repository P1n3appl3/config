#!/bin/bash

set -o pipefail

img_path=/tmp/latest_screenshot.png

maim -u$1 | tee $img_path | xclip -selection c -t image/png &&
    cp $img_path ~/Images &&
    cp $img_path ~/Images/screenshots/$(date +%s).png &&
    notify-send -u Low 'screenshot taken'
