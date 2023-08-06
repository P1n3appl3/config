I use a [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles) to
track my dotfiles and [home-manager](https://nixos.wiki/wiki/Home_Manager) to
grab all the tools I use (like my editor and shell with their plugins).

`config` is aliased to the git command for this repo so I can just
`config add .someconfigfile` from anywhere under my home dir and then
`config commit` like it's a normal workspace.

[This script](/.config/scripts/setup.sh) grabs my dotfiles, sets up that alias,
and installs necessary tools with nix, backing up any conflicts it finds along
the way.
