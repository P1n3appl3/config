## Shell

* atuin
  * fix [crossterm bug](https://github.com/crossterm-rs/crossterm/issues/685) so `ctrl+backspace` [works](https://github.com/atuinsh/atuin/issues/941)
  * reverse order like fzf's UI
  * use my own sync server on Cortana
  * feed zsh_autosuggest from atuin (references: [\[1\]](https://gist.github.com/tyalie/7e13cfe2ec62d99fa341a07ed12ef7c0) [\[2\]](https://pastebin.com/RXxU6rT4) [\[3\]](https://github.com/atuinsh/atuin/issues/68#issuecomment-1582815247)):
``` sh
_zsh_autosuggest_strategy_atuin() {
    suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
}
ZSH_AUTOSUGGEST_STRATEGY=atuin
```
  * maybe shift or ctrl up for ^ while leaving normal up as vanilla zsh history?
* get/write a `command-not-found`
* remove direnv `copy_function` workaround once [this](https://github.com/direnv/direnv/issues/68) lands
* fzf
  * bind ctrl-backspace (instead of alt) to delete last word (see [issue](https://github.com/junegunn/fzf/issues/2057))
  * navigate up a directory (see [comment](https://github.com/junegunn/fzf/issues/3159#issuecomment-1424575660). something like `--bind 'backward-eof:reload(__fzf "$(pwd)/.." $2)'`

## Editor

* set `o.cmdheight = 0` when "press enter" prompts [are stamped out](https://github.com/neovim/neovim/issues/22478)
* find an equivalent to vim's [`:set wrap smoothscroll`](https://vimhelp.org/options.txt.html#%27smoothscroll%27)
* check if my [underline-mixing issue](https://github.com/neovim/neovim/issues/22371) has been resolved in a way that I like
* alt+hjkl to navigate TS nodes (ctrl+alt to swap)
  * try ziontee113/SelectEase or ziontee113/syntax-tree-surfer
* fix ctrl-backspace in fzf-lua
* try wilder.nvim or noice (which can also replace fidget) instead of fzf command palette
* [click to dismiss notifs](https://github.com/rcarriga/nvim-notify/issues/195)
* treesitter highlight groups
* try [catppuccin](https://github.com/catppuccin/nvim) or [gruvbox](https://github.com/ellisonleao/gruvbox.nvim)
  * add my statusline highlights
  * see if subsetting helps perf
* add beancount commentstring in treesitter or upstream
* typst
  * typstfmt not running through lsp
  * get treesitter highlights.scm working
* add alias for `<space> w -> <C-w>` in which-key (see [issue](https://github.com/folke/which-key.nvim/issues/160))
* check if `K` default bind works for lsp ([should have landed?](https://github.com/neovim/neovim/pull/24331 )) and remove my bind for it
* try nvim-ufo for folding
* remove cellular-automata custom plugin definition once [it lands upstream](https://github.com/NixOS/nixpkgs/pull/260973)
* replace neoformat with swap for formatter.nvim or conform.nvim once they reach parity
* write nasm and gn treesitter grammars
* fix treesitter highlighting by automating the linking of queries: `/nix/store/*-tree-sitter-foo-grammar/queries/foo -> ~/.config/nvim/queries`
  * or figure out how to register custom with nvim-treesitter
  * try [tree-sitter-typst](https://github.com/frozolotl/tree-sitter-typst)
  * fix buildGrammar hanging link when trying to use the hypr grammar/vimplugin
* try parinfer-rust with lisp or yuck
* try cmp-kitty and maybe cmp-under-comparator
* nvim-dap + cmp-dap (see [guide](https://davelage.com/posts/nvim-dap-getting-started))
* any excuse to use [perfanno.nvim](https://github.com/t-troebst/perfanno.nvim) and [compiler-explorer](https://github.com/krady21/compiler-explorer.nvim) or [godbolt.nvim](https://github.com/p00f/godbolt.nvim) would be lovely

## Terminal emulator

* fix kitty bold/italic [autodetection](https://github.com/kovidgoyal/kitty/blob/master/kitty/fonts/fontconfig.py) for SourceCodePro
* better scrollback pager for kitty
  * try using `page`
  * maybe just write to /tmp and open
  * see [related issue](https://github.com/kovidgoyal/kitty/issues/719#issuecomment-952039731) and [nvim plugin](https://github.com/mikesmithgh/kitty-scrollback.nvim)
* [remove wezterm bundled fonts](https://github.com/wez/wezterm/blob/main/README-DISTRO-MAINTAINER.md#un-bundling-vendored-fonts)
* try wezterm multiplexing
* try rio

## Desktop Environment

* fix i3status-rs no longer toggling pavucontrol on click
* save/restore layouts for restarts and/or just have good auto-opens on startup
* fix xcolor not working when launched by i3, seems to fail around [here](https://github.com/Soft/xcolor/blob/969d6525c4568a2fafd321fcd72a95481c5f3c7b/src/location.rs#L32)
* test if mime default apps are working and add others
* remove associations for wine, add associations for osu/slp/etc.
* fzf chafa image previews (or just kitty protocol?)
  * file transfer mode should work since it's out of band, see [issue](https://github.com/kovidgoyal/kitty/issues/2238)
  * try `kitten icat --transfer-mode file --place 20x20@40x40 --clear "$f"`
* screenshot.sh remove wayland support if using a dedicated tool, and write/yoink slop shader for blur in i3
* fonts
  * verify that gtk is using noto with some simple gtk app and the inspector
  * look into opentype options with opentype.dev or other fonts:
    * dejavu victor menlo/meslo fira hack hasklig isoveka jetbrains mononoki ubuntu berkely (and check chat thread from work for others)
  * use the nixos fontconfig options and grabbing the resulting xml osConfig for home-manager instead of hand-writing the whole thing
  * try numderline
* music
  * try clerk or rofi-mpd instead of song.sh
  * try music-player (rust) and better tagging for beets
  * beets set max quality with "convert" plugin
  * check that media keys got auto-bound by mpdris2
  * re-add ytmdl once [it's fixed](https://github.com/NixOS/nixpkgs/issues/278376)
* performance
  * use powertop/turbostat/eventstat/pidstat/smemstat/powerstat/power-calibrate to see the difference with hyprland vs sway and ironbar vs i3status-rs
  * ironbar widget to show current power draw (and graph?), and select between governors
* oneko/xsnow/xeyes/xkill/xmascot
  * for oneko, see [shimeji](https://wiki.hyprland.org/Configuring/Uncommon-tips--tricks/#shimeji)
* firefox
  * onetab replacement, go to obsidian
  * [tune smooth scroll params](https://www.reddit.com/r/firefox/comments/13gdu1k/comment/jk3rhm9)
* ironbar circular dials
* ironbar icons not picking up home-manager icons, maybe gtk_data_dirs related?

## Theme

Currently I'm trying out using catppuccin-mocha-pink everywhere I can manage, though a lot of stuff is still vaguely gruvbox. This [darcula config](https://github.com/addy419/configurations/blob/master/modules/colorschemes/dracula.nix) is a good reference of stuff that can be themed.

* fix [rounded corner issue](https://github.com/catppuccin/gtk/issues/129)
* rofi
* qt (kvantum) seems broken currently, see sioodmy's config
* imhex
* firefox homepage and/or userstyles
* cursor maybe? also try qogir and graphite
* i3/i3status
* hyprland/ironbar
* swaync
* nvim
* [obsidian](https://github.com/catppuccin/obsidian)
* kitty/wezterm/rio
  * does terminal emulator cover most stuff, or will eza/htop/etc. need additional config?

## Other

* rust share target dir with [targo](https://github.com/sunshowers/targo)
* powertop handle kitty terminfo
* tlp fix locale issue
* ruff use human readable config names [once that's an option](https://github.com/charliermarsh/ruff/issues/1773)
* git
  * ssh key commit signing
  * use an actual difftool like nvimdiff/fugitive/gnome meld/etc.
* nss doesn't work for stuff like `htop` and `eza` in home-manager on my work computer, running the system's version of `nscd` seems to fix it but that service keeps going down.
* try xplr/joshuto
* htop config param for number of cores, add io screen once [this](https://github.com/nix-community/home-manager/pull/3846) gets merged
* j don't create dir in `$HOME`, also grab an older version while it's broken (i think due to the llvm 16 bump?)
* typst-lsp broken
* mod+o use rofi file completion starting from ~ and xdg-open
* usbtop needs pcap settings
* fontfor broken

## Nix stuff

* don't expose packages if `meta.platforms != system`, currently I use excludes in `garnix.yaml` for this
* Upstream the nixGL wrapper I use
* add a custom livedisk flake output
* add a vm flake output
* export home/nixos modules separately from hosts, use a layout like [misterio's starter config](https://github.com/Misterio77/nix-starter-configs/blob/main/standard/flake.nix)
* my `warnIfUpdated` util function seems broken, though I could have sworn it worked at one point. I might be missing something about how evaluation caching works (I've noticed that other home-manager warnings only show up a single time after I `nix flake update` )
* pull out into redistributable home-manager module
* profile flake eval time, see [this thread](https://discourse.nixos.org/t/nix-flamegraph-or-profiling-tool/33333)
* use flake registry to make local devshells update to my system config's pinned nixpkgs version

## NixOS stuff
* use impermanence and make root ephemeral, see [example](https://git.sr.ht/~misterio/nix-config/tree/main/item/hosts/common/optional/ephemeral-btrfs.nix) and [guide](https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html).
* post processing to get useful output out of: `sudo btrfs send --no-data -p /blank / | btrfs receive --dump`
* maybe create a snapshot right after boot and then diff it upon shutdown, possibly saving a snapshot with whatever new files exist before they get wiped on the next reboot. btrfs subvolume find-new might be the thing
* `fd . / --mount -tf` is also maybe enough?
* consider whether impermanence is even worth the hassle if it's just for root, do I want to try using it in `$HOME` too? seems like more trouble than it's worth at the moment...
* make sure zsh gets completions and bash completions (fwupdmgr) from system packages

## little tools/scripts/patches I should write

* Something like [nvd](https://gitlab.com/khumba/nvd) with some additional features:
  * total size diff of closure
  * gives date→date and try to pull out git hashes to make that link to the diff
  * Should be possible given that it's being automated [here](https://github.com/EdenEast/nyx/pull/101) by [this action](https://github.com/EdenEast/nyx/blob/main/.github/workflows/pr.yml).
    * put it in `system.activationScripts.diff`
        * do the same for `home.activation.diff` unless under nixos
* Ask rahul about the sqlite thing (possibly the one mentioned [here](https://github.com/NixOS/nixos-channel-scripts/issues/45)) as a potential alternative to nix-locate. I'd really like to have a search experience on the command line that's as good as the online one:
  * prioritization and filtering on pname/binary/description/files in package/etc.
  * show packageSets
  * link to source definition in nixpkgs (the one in my nix store if possible? that won't have git history though... maybe point it at a local nixpkgs checkout if it exists and otherwise link to github)
  * extra info such as NAR size, closure size, diff of closure with current system if that's doable, version, last updated date, etc.
  * the [command-not-found rust rewrite](https://github.com/nix-community/nix-index/pull/227) could be a good example
* pokedex neofetch on shell startup
* cat motd
* prettier lsp log viewer for nvim (see [issue](https://github.com/neovim/neovim/issues/16807))
* numbat
  * implement `-> fraction` with [this functionality](https://github.com/sharkdp/numbat/issues/202)
  * get oC and oF working
  * -> hex/octal/binary
  * k for thousands
  * currency fetch cache window
  * write rofi script
  * support for precise rationals and pretty-printing answers as proper fractions
  * set default unit for kinds of quantity (for example J or calorie for energy)
  * look into symbolic algebra
* fuzzy select browser tab and focus it, maybe just firefox extension improving ctrl+shift+a
  * order by history of focus by default
* package asm-lsp and add goto def functionality
  * maybe improve the data scraping bit too
* btm add scrolling dots for active task like btop

## Games

* slippi + kernel module + skins? see [ssbm-nix](https://github.com/djanatyn/ssbm-nix)
* [hsdlib](https://github.com/rrbutani/HSDLib) and xdelta for modding
* everest for celeste, r2modman for ror2, the ftl mod manager, etc.
* use flatpak for fightcade
* minecraft + mods, maybe use [nix-minecraft](https://github.com/Infinidoge/nix-minecraft)
* looking glass hooked up to dual boot partition
* might need [this](https://github.com/danielfullmer/nixos-nvidia-vgpu) for nvidia (and also [this](https://github.com/DualCoder/vgpu_unlock))
* sabaki sgf viewer
* shattered-pixel-dungeon or maybe just steam version
* ruffle or that other one I used on windows for flash stuff
* osu-lazer try low latency pipewire from [nix-gaming](https://github.com/fufexan/nix-gaming) and open tablet driver
* [100r](https://github.com/egasimus/rabbits)
* lutris sc remastered/2, hearthstone, overwatch (see [battle.net](https://nixos.wiki/wiki/Battle.net))
* gunz the duel
* itch check wine setup
* ludosavi check which games aren't covered, set up periodic backups
* rhythm doctor and that one from itch.io, check that it works while floating
* asciiportal
* OG elite or more modern remake in the spirit of it
* pokefinder + timer and assorted tools
* hoyle boardgames + fantastic contraption

## `pkgs/`

* `butter`
  * follow the [upstream instructions](https://github.com/zhangyuannie/butter/blob/main/BUILDING.md). Does the fact that they drive the rust build with meson/ninja mean that I can't use the usual nixpkgs rust infrastructure?
  * ensure that systemd timers it creates actually get triggered, is the service user or system level?
  * remove garnix exclude once it's working

## Hosts

### Cortana

* rust-motd + cats
* add dnsmasq addblock and [prometheus exporter](https://github.com/google/dnsmasq_exporter) for pretty dashboard
* [ad block](https://www.imaginaryrobots.net/posts/2022-01-26-full-network-adblocking-with-dnsmasq/)
* add rust-rpxy config for all the following, add prometheus output for grafana ([looks like they want that too](https://github.com/junkurihara/rust-rpxy/blob/9123ef71a2da473f7c47ca5a21f1a787fca6c540/TODO.md?plain=1#L20))
* add atuin sync server and set bash/zsh to use mine
* add gpodder and configure desktop client and antenna to use it
* add recipe sage/tandoor/kitchenowl recipes and move ours over
* add syncthing introducer with static config and fallback relay or just MxN
  * prometheus metrics hookup!
* add vaultwarden server and hook up phone/browsers
* [host some docs](https://jade.fyi/blog/docs-tricks-and-gnus/) with nice css
  * home manager manual like mipmip's, but autoupdating
* friends.nix (authorizedkeys)
* [service dashboard](https://status.catgirl.cloud/) with uptime kuma
  * maybe send telegram message when stuff goes down
* [ntfy](https://ntfy.sh/) push notifs for service status events
* git frontend, either something like mitxela's or tea or [soft serve](https://github.com/charmbracelet/soft-serve)
* endlessh
  * [hook up fail2ban](https://demu.red/blog/2019/04/endlessh-html-scoreboard/)
  * troubleshoot `-geoip_supplier ip-api`
  * use [local geoip database](https://dev.maxmind.com/geoip/geolite2-free-geolocation-data)
  * hook up to grafana
* static site with sws
  * consistent banner with nav and no name
  * pull out rss reader
  * [hook up to grafana](https://github.com/static-web-server/static-web-server/pull/296)

### WOPR

* do i want `powerManagement.powerTop.enable = true;` (autotune every boot)
* subvols for: `.cache`, `.cargo`, `dev`, steam, maybe all of `games` or just slippi replays
* sleep states, suspend to ram, hibernate, lid close and idle timeout
  * `services.upower = { enable = true; criticalPowerAction = "Hibernate"; };`
  * services.logind power button hibernate, lid close suspend->hibernate with delay
* fw-ectool
  * lights! need to see how fast I can alternate and how wide the gamut is
  * flicker pattern upon plugging in and/or do gradient while charging
* pick interface name wlan0
* startup (check time with systemd-analyze)
  1. systemdboot (decrease picker time to 1 or 2 seconds)
  2. auto-login ([only on tty1](https://gist.github.com/caadar/7884b1bf16cb1fc2c7cde33d329ae37f))
  3. start hyprland (check tty in shell login)
  4. [start portal and update systemd env](https://wiki.hyprland.org/FAQ/#some-of-my-apps-take-a-really-long-time-to-open)
  5. [launch stuff like wallpaper](https://github.com/Gl00ria/dotfiles/blob/main/dot_hyprland/.config/hypr/autostart)
  6. run waylock/swaylock
* set caps=esc and super<->alt in hyprland if the home-manager/nixos ones don't apply
* do ^ in the tty (check that `i18n.consoleUseXkbConfig` is working)
* nixos-rebuild can't see user level flake registry (maybe beccause sudo?)
* dbus-tool or qdbus talk to geoclue
* disable middle-click paste
* howett.net fnlock light to capslock
  * bind caps to esc or ctrl when held
  * swap alt/win
  * right ctrl -> fn
  * key repeat for brightness keys
* no completion for systemd units
* [low latency audio](https://github.com/Aylur/dotfiles/blob/main/nixos/audio.nix)

### clu

* Natural scroll on by default
* [caps lock disk indicator](https://github.com/MeanEYE/Disk-Indicator)

### HAL

* use [looking-glass](https://looking-glass.io/)(see [comments](https://news.ycombinator.com/item?id=28817981)) or [ovmf](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF), or just directly use [vfio](https://b1nzy.com/blog/vfio.html)
  * boot existing windows partition as a vm
  * either splitting gpu or somehow disabling it for the current WM session
