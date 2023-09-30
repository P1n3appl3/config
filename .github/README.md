I use [Home Manager](https://nixos.wiki/wiki/Home_Manager) and [NixOS](https://nixos.org) to manage my configuration declaratively. This repo is a [flake](https://nixos.wiki/wiki/Flakes) that defines configurations for each of my machines, as well as some software I've packaged because they weren't in Nixpkgs:

```
config 🍍 nix flake show
git+file:///home/joseph/config
├───homeConfigurations
│   ├───HAL: main desktop
│   ├───WOPR: main laptop
│   ├───ATLAS: steamdeck
│   ├───clu: $work laptop
│   ├───rinzler: $work desktop
│   └───crabapple: $work mac mini
├───nixosConfigurations
│   ├───Cortana: my trusty RPi4B
│   └───testvm: for messing around with
└───packages
    └───x86_64-linux
        ├───ascii-rain: pretty terminal rain animation
        ├───barchart: draw barcharts in the terminal
        ├───cargo-clone-crate: better cargo clone command
        ├───fio-plot: disk benchmarking tool
        ├───git-heatmap: view change frequency of files in git repo
        ├───lowcharts: draw plots and histograms in the terminal
        └───measureme: rust compiler self profiling tools
    ...
```

Up until cd6d498014c4b2166828158e6b98a5852dc5c50c, I used this as a [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles). If you're not sold on nix/home-manager I think it's still a pretty ideal way to manage your dotfiles. Now when my Home Manager activation script runs, it symlinks everything in the [dotfiles dir](dotfiles) into `$HOME` so that you can edit most config files without having to run "switch"

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
