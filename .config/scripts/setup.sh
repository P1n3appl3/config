#!/usr/bin/env bash

cd
git clone --bare https://github.com/P1n3appl3/config.git .cfg
alias config="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
if ! config checkout; then
    mkdir -p .config-backup
    echo "Backing up pre-existing config files."
    config checkout 2>&1 | grep '^\s' | sed 's/^\t//g' | while read -r f; do
        mkdir -p .config_backup/"$(dirname "$f")"
        mv "$f" .config_backup/"$f"
    done
    config checkout
fi
config config status.showUntrackedFiles no
ln -s .config config

if ! type nix; then
    curl --proto '=https' --tlsv1.2 -sSf -L \
        https://install.determinate.systems/nix | sh -s -- install
fi
nix run nixpkgs#home-manager -- switch --flake .config/nix-config#$(hostname)
