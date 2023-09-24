#!/usr/bin/env bash

f="$1"
mime=$(file -b --mime-type "$f")
category=${mime%%/*}
kind=${mime##*/}

if [ "$kind" = symlink ]; then
    eza -l --no-user --no-permissions --no-time --no-filesize "$f"
elif [ "$category" = inode ]; then
    eza --icons "$f"
elif [ "$category" = image ]; then
    columns=$(tput cols)
    columns=$((columns / 2))
    identify -format '%wx%h\n' "$f"
    chafa -s $columns -f symbols "$f"
    # TODO: get this working... file transfer mode should be fine because it's
    # out of band so it wont just get echo'd into fzf's preview terminal window
    # https://github.com/kovidgoyal/kitty/issues/2238
    # kitten icat --transfer-mode file --place 20x20@40x40 --clear "$f"
elif [ "$category" = text ]; then
    bat -p --color=always "$f" 2>/dev/null
else
    name=$(basename "$f")
    size=$(stat -c %s "$f" | numfmt --to=iec-i --suffix=B --format="%.2f")
    echo "$name is an $size binary file"
fi
