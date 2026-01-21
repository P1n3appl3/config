# TODO: completion configuration (troubleshoot kill signals not showing up)
# TODO: keybindings

if status is-login
    fish_add_path -P $HOME/.cargo/bin
    fish_add_path -P $HOME/.local/bin
end

set -e __HM_SESS_VARS_SOURCED
source ~/.nix-profile/etc/profile.d/hm-session-vars.fish

abbr -a config git -C $CONF_DIR
abbr -a reload exec fish

set -gx fish_lsp_diagnostic_disable_error_codes 4004

function fish_greeting
    random choice "Hello!" Hi Howdy Yo "Meowdy :3"
end

function mkconfig
    set -l name $argv[1]config
    set -e argv[1]
    eval "function $name
        pushd $CONF_DIR >/dev/null; hx dotfiles/{$argv}; popd >/dev/null
    end"
end

mkconfig hx .config/helix/config.toml, .config/helix/languages.toml
mkconfig vim .config/nvim/init.lua, ".config/nvim/**/*.lua", ".config/nvim/**/*.vim"
mkconfig zsh .zshrc, .zshenv, ".config/zsh/*"
mkconfig fish .config/fish/extra.fish, ".config/fish/conf.d/*"
mkconfig i3 .config/i3/config, .config/i3status-rust/config.toml
mkconfig sway .config/sway/common_config, .config/sway/(hostname -s), \
    .config/waybar/config.jsonc, ".config/waybar/*.css"
mkconfig wez .config/wezterm/config.lua, ".config/wezterm/*.lua"
mkconfig git .config/git/extraConfig, .config/git/ignore, ".config/git/*"
mkconfig nix ../mixins/home/common.nix, "../**/*.nix"

set -x MANPAGER less -M -j5 +Gg
set -x PATH (printf '%s\n' $PATH | awk '!seen[$0]++')
set -x EDITOR hx
set -x VISUAL hx
set -g fish_cursor_default line

function p
    string split ' ' $PATH | sd $HOME '~'
end
abbr -a vi hx
abbr -a cat bat
function l
    eza --icons --time-style relative --color-scale all --group-directories-first $argv
end
abbr -a unset set -e
abbr -a ls l -l
abbr -a la l -la
abbr -a tree l -T --git-ignore
abbr -a o xdg-open
abbr -a c clear
abbr -a please sudo
abbr -a fuck killall
function note
    cd ~/documents/notes && hx todo/TODO.md **/*.md && cd -
end

abbr -a send "wormhole-rs tx"
abbr -a receive "wormhole-rs rx"
abbr -a rs rsync -a --info=progress2
abbr -a getsong "ytmdl --dont-transcode --download-archive ~/.cache/ytmdl/archive"
abbr -a wine32 "WINEPREFIX=$HOME/.wine32 wine"
function ststatus
    syncthing cli show system |
        jq -r '.myID, .uptime, .startTime, .guiAddressUsed, .cpuPercent' |
        read -L id uptime start url cpu
    echo -e "ID: $id\nStarted $start $(numbat -e "print("$uptime"s to human)")"
    echo -e "CPU: $cpu%\nGUI: $(echo $url | sd 127.0.0.1 localhost)"
end

abbr -a sc systemctl
abbr -a music rmpc
abbr -a m music
function shuffle
    mpc clear && mpc ls | mpc add && mpc shuffle && mpc play
end

abbr -a bp factorio-bp-helper
function fontcheck
    set -ql font $argv[2]; or set font sans
    FC_DEBUG=4 pango-view -q -t $argv[1] --font=$font &|
        rg -or '$1' 'family: "([^"]+)"' | tail -1
end

function nixfind
    nix-locate --color=always -rt r -t x -t s $argv | sd '/nix/store/[^/\x1b]+' '' | sort
end

abbr -a nixsize nix-tree
abbr -a nixclean nh clean all

function _switch
    if test (uname) = Darwin
        set cmd darwin
    else if command -qv nixos-rebuild >/dev/null
        set cmd os
    else
        set cmd home
    end
    nh $cmd switch $CONF_DIR $argv
end
abbr -a switch _switch
abbr -a update switch -u

function give-me-a-ping-vasily
    # One Ping Only...
    echo -n "Ping: "
    ping -qc1 -W1 $argv[1] &| awk -F/ 'END{ print (/^rtt/? "OK "$5" ms":"FAIL") }'
end

function repeat
    for i in (seq $argv[1])
        eval "$argv[2..]"
    end
end

function fzf-dir-widget
    FZF_CTRL_T_COMMAND=$FZF_ALT_C_COMMAND fzf-file-widget
end

bind ctrl-f fzf-file-widget
bind ctrl-g fzf-dir-widget
bind ctrl-e edit_command_buffer
bind ctrl-k up-or-search
bind ctrl-j down-or-search
