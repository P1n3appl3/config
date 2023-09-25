I use this as a [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles) to
track my dotfiles.

`config` is aliased to the git command for this repo so I can just
`config add .someconfigfile` from anywhere under `$HOME` and then
`config commit` like it's a normal workspace.

[This script](/.config/scripts/setup.sh) clones this repo, and checks it out in
`$HOME` backing up any conflicts it finds along the way.

The [nix flake](/.config/nix-config/flake.nix) in this repo defines
[home-manager](https://nixos.wiki/wiki/Home_Manager) and [NixOS](https://nixos.org)
configurations for many of my machines. This allows me to easily grab all the
packages I need (like my editor and shell with their plugins). When possible I
use NixOS to manage the entire system. ~~[garnix](https://garnix.io) gives me
nice speedy CI and caching so I don't have to rebuild my custom packages on
all of my machines:~~ I'd really like to use [garnix](https://garnix.io) for
CI, but I currently can't due to [this issue](https://github.com/garnix-io/issues/issues/27).

<div align="center">
  <a href="https://garnix.io"><img alt="not built with garnix (yet)" src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2Fp1n3appl3%2Fconfig"></a>
</div>
