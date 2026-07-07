I use [NixOS](https://nixos.org) and/or [Home Manager](https://nixos.wiki/wiki/Home_Manager) to declaratively manage my computers. This repo is a [flake](https://nixos.wiki/wiki/Flakes) that defines configurations for each of my machines, as well as some software I've packaged because they weren't in [Nixpkgs](https://search.nixos.org/packages):

```
config 🍍 nix flake show
├───homeConfigurations
│   ╰───ATLAS: steamdeck
├───nixosConfigurations
│   ├───HAL:     main desktop
│   ├───WOPR:    framework laptop 13" (AMD 7640U)
│   ├───Cortana: raspberry pi 4B
│   ╰───ISO:     bootable image for bootstrapping
├───homeModules
│   ╰───fightcade: wrapper to play retro fighting games
├───nixosModules
│   ├───m-overlay:    security wrapper for input viewer
│   ├───porkbun-ddns: update ip for porkbun DNS entries
│   ╰───rust-rpxy:    reverse proxy service
├───overlays
│   ╰───default: Nixpkgs overlay with my packages and overrides
╰───packages
    ├───android-messages: desktop messages client
    ├───apotris: block stacking game
    ├───ascii-rain: pretty terminal rain animation
    ├───audio-select: pulse-audio device selector
    ├───autumn: autumn leaves solitaire card game
    ├───barchart: draw barcharts in the terminal
    ├───basic-pitch: audio to midi transcriber
    ├───bibata-modern-classic: mouse cursor theme
    ├───bridge: rythm game chart downloader
    ├───cached-path: download a resource once, then return that path
    ├───cargo-clone-crate: better cargo clone command
    ├───cachedtom: local-first cargo toml language server
    ├───circuit-artist: the best EDA software since logisim
    ├───cos-cli: cli for manipulating cosmic-desktop windows
    ├───d-rs: stream processing utilities
    ├───dl: get the latest downloaded file
    ├───ds-rom: extract nintendo ds rom files
    ├───eontimer: pokémon RNG timer
    ├───fence: chess board visualizer
    ├───fio-plot: disk benchmarking tool
    ├───gc-fst: gamecube filesystem extractor/rebuilder
    ├───get-keys: bespoke tool to grab my ssh keys
    ├───git-coauthor: easily add coauthors to the previous commit
    ├───git-heatmap: view change frequency of a repo
    ├───git-undeadname: does what it says on the tin
    ├───glkitty: gears demo in the terminal
    ├───hgecko: wrapper/helper for devkitpro ppc toolchain
    ├───hovalaag: assembly programming game
    ├───hmex: elf/dat manipulation tool using devkitpro
    ├───input-integrity: gamecube controller adapter manager
    ├───launchk: macos launchd tui
    ├───lowcharts: draw plots and histograms in the terminal
    ├───m-overlay: gamecube input visualizer for dolphin
    ├───melee-quick-mod: ssbm texture patcher
    ├───minidump-debugger: gui minidump inspector
    ├───minidump-stackwalk: cli minidump tool
    ├───nasa-wallpaper: show nasa pictures of the day as wallpaper
    ├───oolite: space exploration role playing game
    ├───peppi-slp: compress and process slippi replays
│   ├───porkbun-ddns: simple ddns client for porkbun
    ├───posting: http api explorer
    ├───protobuf-language-server: LSP support for .proto files
    ├───rssfetch: RSS feed scraper
    ├───rsspls: RSS feed generator (for sites with no feed)
    ├───rust-rpxy: simple reverse proxy
    ├───rwing: melee replay review tool
    ├───s2yt: spotify to youtube music transfer tool
    ├───slippc: compress/analyze slippi replays
    ├───slp2mp4: convert slippi replays to videos
    ├───slp-to-video: convert slippi replays to videos
    ├───slpz: compress slippi replays faster
    ├───tab: command line music tabs
    ├───term-rustdoc: tui docs browser
    ├───uwurandom: like /dev/urandom, but objectively better
    ╰───zeco: zellij remote multiplayer
```

I [used to](https://github.com/P1n3appl3/config/tree/cd6d498014) use this as a [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles). If you're not sold on nix/home-manager I think it's still a pretty ideal way to manage your dotfiles. Now when my home-manager activation script runs, it symlinks everything in the [dotfiles dir](dotfiles) into `$HOME` so that you can edit most config files without having to run `switch`.

[garnix](https://garnix.io) gives me speedy CI and caching so I don't have to rebuild my packages or overrides on all of my machines:

<div align="center"><a href="https://garnix.io"><img alt="built with garnix" src="https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2FP1n3appl3%2Fconfig"></a></div>

I learned a lot from trawling through other peoples configs, here are some cool ones to check out:

- <https://github.com/Misterio77/nix-config>
- <https://github.com/rrbutani/nix-config>
- <https://gitlab.com/lunik1/nix-config>
- <https://git.jhink.org/jacob/nix_config>
- <https://github.com/sioodmy/dotfiles>
- <https://xeiaso.net/blog/prometheus-grafana-loki-nixos-2020-11-20/>/<https://xeiaso.net/blog/nix-flakes-3-2022-04-07/> (they have lots of good nix related posts)
- <https://ianthehenry.com/posts/how-to-learn-nix/overriding/> (and other parts of that series)
- <https://github.com/PROxZIMA/.dotfiles/> (not nix, just pretty)
- <https://github.com/siduck/dotfiles> (ditto)
