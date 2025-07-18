## Shell

* atuin
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
* direnv set verbosity option [once it lands](https://github.com/direnv/direnv/pull/1231)
* fzf
  * bind ctrl-backspace (instead of alt) to delete last word (see [issue](https://github.com/junegunn/fzf/issues/2057))
  * navigate up a directory (see [comment](https://github.com/junegunn/fzf/issues/3159#issuecomment-1424575660). something like `--bind 'backward-eof:reload(__fzf "$(pwd)/.." $2)'`
* starship tty ascii
* inputrc for bash
* fish?
* [worktree switcher](https://github.com/mateusauler/git-worktree-switcher)

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
* try [gruvbox](https://github.com/ellisonleao/gruvbox.nvim)
  * add my statusline highlights
  * see if subsetting helps perf
* add beancount commentstring in treesitter or upstream
* typst
  * typstfmt not running through lsp
  * get treesitter highlights.scm working
* add alias for `<space> w -> <C-w>` in which-key (see [issue](https://github.com/folke/which-key.nvim/issues/160))
* try nvim-ufo for folding
* remove cellular-automata custom plugin definition once [it lands upstream](https://github.com/NixOS/nixpkgs/pull/260973)
* replace neoformat with swap for formatter.nvim or conform.nvim once they reach parity
* write nasm and gn treesitter grammars
* fix treesitter highlighting by automating the linking of queries: `/nix/store/*-tree-sitter-foo-grammar/queries/foo -> ~/.config/nvim/queries`
  * or figure out how to register custom with nvim-treesitter
  * try [tree-sitter-typst](https://github.com/frozolotl/tree-sitter-typst)
* try parinfer-rust with lisp or yuck
* try cmp-kitty/cmp-wezterm
* nvim-dap + cmp-dap (see [guide](https://davelage.com/posts/nvim-dap-getting-started))
* any excuse to use [perfanno.nvim](https://github.com/t-troebst/perfanno.nvim) and [compiler-explorer](https://github.com/krady21/compiler-explorer.nvim) or [godbolt.nvim](https://github.com/p00f/godbolt.nvim) would be lovely
* treesj nix language turn attr-path into separate attrset within binding
* lsp.type.unresolvedReference.rust -> greyed out a bit or italic or something, can i mess with existing fg color
* check that gitgutter + lsp signs + dap signs is working in tandem

## Terminal emulator

* fix kitty bold/italic [autodetection](https://github.com/kovidgoyal/kitty/blob/master/kitty/fonts/fontconfig.py) for SourceCodePro
* [kitty icon](https://github.com/igrmk/whiskers)
* better scrollback pager for kitty
  * try using `page`
  * maybe just write to /tmp and open
  * see [related issue](https://github.com/kovidgoyal/kitty/issues/719#issuecomment-952039731) and [nvim plugin](https://github.com/mikesmithgh/kitty-scrollback.nvim)
* [remove wezterm bundled fonts](https://github.com/wez/wezterm/blob/main/README-DISTRO-MAINTAINER.md#un-bundling-vendored-fonts)
* try wezterm multiplexing
* try kitty-img

## Desktop Environment

* audioselect
  * wayland support so it's positioned under your cursor
  * monitors for the inputs and outputs, maybe as button background?
  * single volume sliders for input and output
* audioselect clone for power profiles on the battery block
* save/restore layouts for restarts and/or just have good auto-opens on startup
* fix xcolor not working when launched by i3, seems to fail around [here](https://github.com/Soft/xcolor/blob/969d6525c4568a2fafd321fcd72a95481c5f3c7b/src/location.rs#L32)
* test if mime default apps are working and add others
* remove associations for wine, add associations for osu/slp/etc.
* fzf chafa image previews (or just kitty protocol?)
  * file transfer mode should work since it's out of band, see [issue](https://github.com/kovidgoyal/kitty/issues/2238)
  * try `kitten icat --transfer-mode file --place 20x20@40x40 --clear "$f"`
* screenshot.sh remove wayland support if using a dedicated tool, and write/yoink slop shader for blur in i3
* fonts
  * fix monospace font not applying in firefox
  * verify that gtk is using noto with some simple gtk app and the inspector
  * look into opentype options with opentype.dev or other fonts:
    * dejavu victor menlo/meslo fira hack hasklig isoveka jetbrains mononoki ubuntu berkely (and check chat thread from work for others)
  * use the nixos fontconfig options and grabbing the resulting xml osConfig for home-manager instead of hand-writing the whole thing
  * try numderline
  * set up comic-neue for primary cursive font
  * try inter for sans serif
* music
  * try clerk or rofi-mpd instead of song.sh
  * try music-player (rust) or [this](https://github.com/Martchus/tageditor) and better tagging for beets
  * beets set max quality with "convert" plugin
  * check that media keys got auto-bound by mpdris2
* performance
  * use powertop/turbostat/eventstat/pidstat/smemstat/powerstat/power-calibrate to see the difference with different bar poll rate and wm
  * ironbar widget to show current power draw (and graph?), and select between governors
* oneko/xsnow/xeyes/xkill/xmascot
  * for oneko, see [shimeji](https://wiki.hyprland.org/Configuring/Uncommon-tips--tricks/#shimeji)
* firefox
  * [tune smooth scroll params](https://www.reddit.com/r/firefox/comments/13gdu1k/comment/jk3rhm9)
* ironbar circular dials
* ironbar icons not picking up home-manager icons, maybe gtk_data_dirs related?
* bar weather widget, [open meteo](https://open-meteo.com) + [free geo ip](https://freegeoip.io/)
* wluma [home-manager module](https://github.com/nix-community/home-manager/issues/2420)
* set --ozone-platform-hint=auto for caprine and other electron apps
* debug logisim(/evolution) blank window on launch
* i3status-rs weather hide if no location (or error emoji instead of message+color)
* [.desktop file finder](https://unix.stackexchange.com/questions/344188/list-all-desktop-files-that-appears-in-application-menu)
* rustdesk enable nixos service

## Theme

Currently I'm trying out using catppuccin mocha everywhere I can manage. This [darcula config](https://github.com/addy419/configurations/blob/master/modules/colorschemes/dracula.nix) is a good reference of stuff that can be themed. There's also [a separate flake](https://github.com/catppuccin/nix) that pre-configures stuff for catppuccin specifically.

* fix [rounded corner issue](https://github.com/catppuccin/gtk/issues/129)
* imhex
* aseprite
* firefox homepage and/or userstyles
* swaync
* [systemd-boot](https://github.com/systemd/systemd/blob/ae9fd433d6e245677e6e916a3461be462362e7b8/meson_options.txt#L477)

## Other

* rust share target dir with [targo](https://github.com/sunshowers/targo)
* ruff use human readable config names [once that's an option](https://github.com/charliermarsh/ruff/issues/1773)
* git
  * use an actual difftool like nvimdiff/fugitive/gnome meld/etc.
  * try difftastic inline mode instead of delta
  * image/pdf/kicad/etc. differs, like [this](https://github.com/ewanmellor/git-diff-image)
* nss doesn't work for stuff like `htop` and `eza` in home-manager on my work computer, running the system's version of `nscd` seems to fix it but that service keeps going down.
* try xplr/joshuto
* htop config param for number of cores, add io screen once [this](https://github.com/nix-community/home-manager/pull/3846) gets merged
* j don't create `j9.x-user` in `$HOME`
* mod+o use rofi file completion starting from ~ with xdg-open
* mod+k rofi kaomoji
* usbtop needs pcap settings
* add /etc/host entry for syncthing (localhost:8383)
* declarative syncthing for all devices, get private key from phone and stick all keys in ragenix

## Nix stuff

* Upstream the nixGL wrapper I use (or use the upstream one they decide on)
* add a custom livedisk flake output
* add a vm flake output
* my `warnIfUpdated` util function seems broken, though I could have sworn it worked at one point. I might be missing something about how evaluation caching works (I've noticed that other home-manager warnings only show up a single time after I `nix flake update`)
* profile flake eval time, see [this thread](https://discourse.nixos.org/t/nix-flamegraph-or-profiling-tool/33333)
* grab the patches for flake schemas
* get debug symbols for nix packages. try debugging sway config parsing

## NixOS stuff

## little tools/scripts/patches I should write

* Something like [nvd](https://gitlab.com/khumba/nvd) with some additional features:
  * total size diff of closure
  * gives date→date and try to pull out git hashes to make that link to the diff
  * Should be possible given that it's being automated [here](https://github.com/EdenEast/nyx/pull/101) by [this action](https://github.com/EdenEast/nyx/blob/main/.github/workflows/pr.yml).
    * put it in `system.activationScripts.diff`
        * do the same for `home.activation.diff` unless under nixos
  * possibly add to `nh` which just uses `nvd`
* Ask rahul about the sqlite thing (possibly the one mentioned [here](https://github.com/NixOS/nixos-channel-scripts/issues/45)) as a potential alternative to nix-locate. I'd really like to have a search experience on the command line that's as good as the online one:
  * prioritization and filtering on pname/binary/description/files in package/etc.
  * show packageSets
  * link to source definition in nixpkgs (the one in my nix store if possible? that won't have git history though... maybe point it at a local nixpkgs checkout if it exists and otherwise link to github)
  * extra info such as NAR size, closure size, diff of closure with current system if that's doable, version, last updated date, etc.
  * the [command-not-found rust rewrite](https://github.com/nix-community/nix-index/pull/227) could be a good example
  * maybe just make PR to `nh search`, it seems closest to what I want
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
* 1 glyph font or noto-color-emoji patch to change the calendar date to my bday

## Games

* slippi + kernel module + skins? see [ssbm-nix](https://github.com/djanatyn/ssbm-nix)
* [hsdlib](https://github.com/rrbutani/HSDLib) and xdelta for modding
* input-integrity
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
* hoyle boardgames + fantastic contraption
* apotris
* airshipper

## `pkgs/`

- https://github.com/chrisduerr/sketch
- https://github.com/Journeycorner/systemd-gtk or https://github.com/pyxvlad/services-gui
- https://github.com/ardaku/whoami
- https://github.com/zquestz/s

## Other

* btrfs rule to not compress db files

## Hosts

### Cortana

* rust-motd + cats/pokedex
* [ntfy](https://ntfy.sh) push notifs for service status events
* add dnsmasq adblock and [prometheus exporter](https://github.com/google/dnsmasq_exporter) for pretty dashboard
  * [dnsmasq info](https://www.imaginaryrobots.net/posts/2022-01-26-full-network-adblocking-with-dnsmasq/)
* add rust-rpxy config for all the following, add prometheus output for grafana ([looks like they want that too](https://github.com/junkurihara/rust-rpxy/blob/9123ef71a2da473f7c47ca5a21f1a787fca6c540/TODO.md?plain=1#L20))
* add atuin sync server and set bash/zsh to use mine
* add gpodder and configure desktop client and antenna to use it
* add recipe sage/tandoor/kitchenowl recipes and move ours over
* add syncthing introducer with static config and fallback relay or just MxN
  * prometheus metrics hookup!
* add vaultwarden server and hook up phone/browsers
* [host some docs](https://jade.fyi/blog/docs-tricks-and-gnus/) with nice css
  * and/or something like <https://becca.ooo/unicode> for other topics
* [service dashboard](https://status.catgirl.cloud/) with uptime kuma
  * maybe send telegram message when stuff goes down
* endlessh
  * [hook up fail2ban](https://demu.red/blog/2019/04/endlessh-html-scoreboard/)
  * troubleshoot `-geoip_supplier ip-api`
  * use [local geoip database](https://dev.maxmind.com/geoip/geolite2-free-geolocation-data)
  * hook up to grafana
* static site with sws
  * consistent banner with nav and no name
  * pull out rss reader
  * [hook up to grafana](https://github.com/static-web-server/static-web-server/pull/296)
* wastebin
  * clear daily?
* detect/handle redir from telegram/hn/etc.
* punycode pineapple emoji subdomain (or just all subdomains like 📈 for grafana)
* git frontend, either something like mitxela's or tea or
  * static list/log/tree view like mitexla
    * include total space in UI
  * [soft serve](https://github.com/charmbracelet/soft-serve)
  * http://codemadness.org/stagit.html
  * check ssh vs http vs git protocol
* [debug usb reconnection](https://www.linuxquestions.org/questions/linux-general-1/rescan-for-usb-devices-754916/)
* no reverse dns lookup for ssh


### WOPR

* do i want `powerManagement.powerTop.enable = true;` (autotune every boot)
* sleep states, suspend to ram, hibernate, lid close and idle timeout
  * `services.upower = { enable = true; criticalPowerAction = "Hibernate"; };`
  * services.logind power button hibernate, lid close suspend->hibernate with delay
* fw-ectool
  * lights! need to see how fast I can alternate and how wide the gamut is
  * flicker pattern upon plugging in and/or do gradient while charging
  * [pattern](https://community.frame.work/t/reprogramming-the-leds-for-the-holidays/12906)
* d-spy/bustle/dbus-tool/qdbus talk to geoclue
* disable middle-click paste
* howett.net fnlock light to capslock
  * bind caps to ctrl when held: https://gitlab.com/interception/linux/plugins/caps2esc
  * right ctrl -> fn
  - right alt -> ? (currently meta)
* [caps lock disk indicator](https://github.com/MeanEYE/Disk-Indicator)
* [only autologin on tty1](https://github.com/NixOS/nixpkgs/issues/81552)
* measure power draw in s2idle, as well as peak and idle (see [here](https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd_s2idle.py))
* screen brightness keys and swayosd or similar for showing brightness
* debug fprintd enroll not working

### HAL

* [low latency audio](https://github.com/Aylur/dotfiles/blob/main/nixos/audio.nix)
* try [looking-glass](https://looking-glass.io/)(see [comments](https://news.ycombinator.com/item?id=28817981)) or [ovmf](https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF), or just directly use [vfio](https://b1nzy.com/blog/vfio.html)
  * boot existing windows partition as a vm
  * either splitting gpu or somehow disabling it for the current WM session
