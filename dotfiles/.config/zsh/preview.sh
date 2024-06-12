#!/usr/bin/env bash

# fzf previewer

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
elif [ "$category" = text ]; then
    bat -p --color=always "$f" 2>/dev/null
else
    name=$(basename "$f")
    size=$(stat -c %s "$f" | numfmt --to=iec-i --suffix=B --format="%.2f")
    echo "$name is an $size binary file"
fi
