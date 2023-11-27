#!/usr/bin/env bash

# TODO: use different picker on wayland
next_song=$(mpc listall | sort -R | rofi -i -dmenu -p song)
[[ -n $next_song ]] && mpc insert $next_song && [[ -n $1 ]] && mpc next
