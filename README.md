I use [NixOS](https://nixos.org) and/or [Home Manager](https://nixos.wiki/wiki/Home_Manager) to manage my configuration declaratively and fetch all the packages I need on the computers I use. This repo is a [flake](https://nixos.wiki/wiki/Flakes) that defines configurations for each of my machines, as well as some software I've packaged because they weren't in [Nixpkgs](https://search.nixos.org/packages):

```
config 🍍 nix flake show
├───homeConfigurations
│   ├───ATLAS: steamdeck
│   ├───HAL:   main desktop
│   ├───clu:       $work laptop
│   ├───crabapple: $work mac
│   └───rinzler:   $work desktop
├───nixosConfigurations
│   ├───Cortana: my trusty RPi4B home server
│   └───WOPR:    framework laptop 13" (AMD 7640U)
├───overlays
│   └───default: Nixpkgs overlay with my packages and overrides
└───packages
    ├───ascii-rain: pretty terminal rain animation
    ├───barchart: draw barcharts in the terminal
    ├───bibata-modern-classic: mouse cursor theme
    ├───butter: ui for btrfs subvolume snapshot history
    ├───cargo-clone-crate: better cargo clone command
    ├───fio-plot: disk benchmarking tool
    ├───git-heatmap: view change frequency of git repo
    ├───lowcharts: draw plots and histograms in the terminal
    ├───rust-rpxy: simple reverse proxy
    └───syncthing-gtk: ui+tray-menu for syncthing
```

I [used to](https://github.com/P1n3appl3/config/tree/cd6d498014) use this as a [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles). If you're not sold on nix/home-manager I think it's still a pretty ideal way to manage your dotfiles. Now when my home-manager activation script runs, it symlinks everything in the [dotfiles dir](dotfiles) into `$HOME` so that you can edit most config files without having to run `switch`.

[garnix](https://garnix.io) gives me speedy CI and caching so I don't have to rebuild my packages or overrides on all of my machines:

<div align="center"><a href="https://garnix.io"><img alt="built with garnix" src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2FP1n3appl3%2Fconfig"></a></div>

I learned a lot from trawling through other peoples configs, here's some cool ones to check out:

- <https://github.com/Misterio77/nix-config>
- <https://github.com/rrbutani/nix-config>
- <https://gitlab.com/lunik1/nix-config>
- <https://git.jhink.org/jacob/nix_config>
- <https://github.com/sioodmy/dotfiles>
- <https://xeiaso.net/blog/prometheus-grafana-loki-nixos-2020-11-20/>/<https://xeiaso.net/blog/nix-flakes-3-2022-04-07/> (they have lots of good nix related posts)
- <https://ianthehenry.com/posts/how-to-learn-nix/overriding/> (and other parts of that series)
- <https://github.com/PROxZIMA/.dotfiles/> (not nix, just pretty)
- <https://github.com/siduck/dotfiles> (ditto)
