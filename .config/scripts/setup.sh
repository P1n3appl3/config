#!/bin/sh

cd
git clone --bare https://github.com/P1n3appl3/dotfiles.git .cfg
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
config checkout
if [ $? != 0 ]; then
    mkdir -p .config-backup
    echo "Backing up pre-existing dot files."
    config checkout 2>&1 | grep '^\s' | sed 's/^\t//g' | while read -r f; do
        mkdir -p .config_backup/"$(dirname "$f")"
        mv "$f" .config_backup/"$f"
    done
fi
config checkout
config config status.showUntrackedFiles no
ln -s .config config
