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
* music
  * try clerk or rofi-mpd instead of song.sh
  * try music-player (rust) and better tagging for beets
  * beets set max quality with "convert" plugin
  * check that media keys got auto-bound by mpdris2

## Theme

Currently I'm trying out using catppuccin-mocha-pink everywhere I can manage, though a lot of stuff is still vaguely gruvbox

* fix [rounded corner issue](https://github.com/catppuccin/gtk/issues/129)
* rofi
* qt (kvantum) seems broken currently, see sioodmy's config
* imhex
* nvim
* firefox homepage and/or userstyles
* cursor maybe? also try qogir and graphite
* i3/i3status
* hyprland/eww
* nvim
* kitty/wezterm/rio
  * does terminal emulator cover most stuff, or will eza/htop/etc. need additional config?

## Other

* powertop handle kitty terminfo
* tlp fix locale issue
* ruff use human readable config names [once that's an option](https://github.com/charliermarsh/ruff/issues/1773)
* git
  * ssh key commit signing
  * use an actual difftool like nvimdiff/fugitive/gnome meld/etc.
* nss doesn't work for stuff like `htop` and `eza` in home-manager on my work computer, running the system's version of `nscd` seems to fix it but that service keeps going down.
* try xplr/joshuto
* htop static hm config with param for number of cores
* j don't create dir in `$HOME`, also grab an older version while it's broken (i think due to the llvm 16 bump?)

## Nix stuff

* don't expose packages if `meta.platforms != system`, currently I use excludes in `garnix.yaml` for this
* Upstream the nixGL wrapper I use
* add a custom livedisk flake output
* add a vm flake output
* export home/nixos modules separately from hosts, use a layout like [misterio's starter config](https://github.com/Misterio77/nix-starter-configs/blob/main/standard/flake.nix)
* my `warnIfUpdated` util function seems broken, though I could have sworn it worked at one point. I might be missing something about how evaluation caching works (I've noticed that other home-manager warnings only show up a single time after I `nix flake update` )
* pull out into redistributable home-manager module

## NixOS stuff
* use impermanence and make root ephemeral, see [example](https://git.sr.ht/~misterio/nix-config/tree/main/item/hosts/common/optional/ephemeral-btrfs.nix) and [guide](https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html).
* post processing to get useful output out of: `sudo btrfs send --no-data -p /blank / | btrfs receive --dump`
* maybe create a snapshot right after boot and then diff it upon shutdown, possibly saving a snapshot with whatever new files exist before they get wiped on the next reboot. btrfs subvolume find-new might be the thing
* `fd . / --mount -tf` is also maybe enough?
* consider whether impermanence is even worth the hassle if it's just for root, do I want to try using it in `$HOME` too? seems like more trouble than it's worth at the moment

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
* improve [cpc](https://github.com/probablykasper/cpc) to the point where it's as nice as qalc
  * default to 6-8 decimal places, maybe responsive based on size of integer component
  * set default unit for kinds of quantity (for example J or calorie for energy)
  * bare unit count as "1 \<unit\>"
  * currency
    * for an official source, the [united states treasury data](https://fiscaldata.treasury.gov/datasets/treasury-reporting-rates-exchange/treasury-reporting-rates-of-exchange) (published quarterly) has a nice api, we can do something like `xh "https://api.fiscaldata.treasury.gov/services/api/fiscal_service/v1/accounting/od/rates_of_exchange?sort=-record_date&filter=record_date:gte:$(date --date '-3 months' +%F)"`
    * I wish we could simply filter to "latest rate for each currency", but I don't see an option for it
    * transparently read from cache or download when a currency is parsed and store a cached copy in a nice to read format with some expiry (daily?)
    * still need a list of abbreviations aka ISO 4217 codes (NGN), unambiguous shortened names (yen/yuan), and symbols (₹), which can probably be maintained manually and mapped to the `country_currency_desc` field to match it with the treasury exchange rates.
    * the federal reserve has [more frequently updated rates](https://www.federalreserve.gov/releases/h10/current/) but for fewer (24) countries.
    * for a possibly less US-centric option the IMF also has [exchange rate data](https://www.imf.org/external/np/fin/data/rms_rep.aspx) for 38 currencies updated daily.
  * help/manpage with list of units/functions/constants
  * abbreviated units for output: square centimeters -> cm²
  * interactive cli
    * simpler version: `p='🧮 >'; echo -n $p; while read -r l; do cpc $l; echo -en "\n$p" ; done`
    * `\ueb64` ( ) from nerdfonts is a nice prompt character
    * readline wrapper gives you history and such: `rlwrap -S "> " -H "${XDG_CACHE_HOME-$HOME/.cache}/cpc-history.txt" xargs -I{} sh -c "echo '';cpc '{}';echo ''"`
    * [rustyline](https://github.com/kkawakam/rustyline) should be pretty easy to integrate
    * completions for constants/functions/units
    * pretty errors like ariadne
    * preview the answer with ghost text (assuming it's not too expensive to run per-keypress)
  * support for precise rationals and pretty-printing answers as proper fractions
  * write rofi script
* fuzzy select browser tab and focus it, maybe just firefox extension improving ctrl+shift+a
  * order by history of focus by default
* package asm-lsp and add goto def functionality
  * maybe improve the data scraping bit too

## Games

- slippi + kernel module + skins? see [ssbm-nix](https://github.com/djanatyn/ssbm-nix)
- [hsdlib](https://github.com/rrbutani/HSDLib) and xdelta for modding
- everest for celeste, r2modman for ror2, the ftl mod manager, etc.
- use flatpak for fightcade
- minecraft + mods, maybe use [nix-minecraft](https://github.com/Infinidoge/nix-minecraft)
- eggnogg / + (+ is on itch so just test that one)
- looking glass hooked up to dual boot partition
  might need [this](https://github.com/danielfullmer/nixos-nvidia-vgpu) for nvidia (and also [this](https://github.com/DualCoder/vgpu_unlock))
- sabaki sgf viewer
- shattered-pixel-dungeon or maybe just steam version
- ruffle or that other one I used on windows for flash stuff
- osu-lazer try low latency pipewire from [nix-gaming](https://github.com/fufexan/nix-gaming) and open tablet driver
- [100r](https://github.com/egasimus/rabbits)
- lutris [league](https://git.sr.ht/~misterio/nix-config/tree/main/item/hosts/common/optional/lol-acfix.nix), sc remastered/2, hearthstone, overwatch (see [battle.net](https://nixos.wiki/wiki/Battle.net))
- gunz the duel
- desmume or other ds emu, gba, nes, n64, 3ds, switch
- itch check wine setup
- ludosavi check which games aren't covered, set up periodic backups

## `pkgs/`

* `butter`
  * follow the [upstream instructions](https://github.com/zhangyuannie/butter/blob/main/BUILDING.md). Does the fact that they drive the rust build with meson/ninja mean that I can't use the usual nixpkgs rust infrastructure?
  * ensure that systemd timers it creates actually get triggered, is the service user or system level?
  * remove garnix exclude once it's working
* `rust-rpxy`
  * debug h3 submodule not getting checked out
  * debug `Cargo.lock` being missing when attempting to build manually with `nix develop`/`nix-shell`
  * remove garnix exclude once it's working

## Hosts

#### Cortana

#### WOPR

* do i want `powerManagement.powerTop.enable = true;` (autotune every boot)
* subvols for: `.cache`, `.cargo`, `dev`
* sleep states, suspend to ram, hibernate, lid close and idle timeout
  * `services.upower = { enable = true; criticalPowerAction = "Hibernate"; };`
* fw-ectool
  * lights! need to see how fast I can alternate and how wide the gamut is
  * flicker pattern upon plugging in and/or do gradient while charging
* startup
  1. systemdboot (decrease picker time to 1 or 2 seconds)
  2. auto-login (should be working)
  3. start hyprland (in check tty in shell login)
  4. [start portal and update systemd env](https://wiki.hyprland.org/FAQ/#some-of-my-apps-take-a-really-long-time-to-open)
  5. [launch stuff like wallpaper](https://github.com/Gl00ria/dotfiles/blob/main/dot_hyprland/.config/hypr/autostart)
  6. run waylock/swaylock
* set caps=esc and super<->alt in hyprland if the home-manager/nixos ones don't apply
* do ^ in the tty (check that `i18n.consoleUseXkbConfig` is working)

#### clu

- Natural scroll on by default
