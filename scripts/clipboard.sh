#!/usr/bin/env bash
tail -n15 -z ~/.clipboard | rofi -i -dmenu -p clip -sep '\0' | wl-copy
