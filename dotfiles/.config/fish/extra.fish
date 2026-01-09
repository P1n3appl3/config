# TODO: completion configuration
# TODO: check shell integration
# TODO: fzf default opts/keybinds/functions
# TODO: keybindings

abbr -a config git -C $CONF_DIR
abbr -a reload exec fish

set -gx fish_lsp_diagnostic_disable_error_codes 4004

function fish_greeting
    random choice "Hello!" Hi Howdy Yo "Meowdy :3"
end

function mkconfig
    set -l name $argv[1]
    set -e argv[1]
    set -l i (contains -i -- -- $argv)

    if test -n "$i"
        set -l paths $argv[1..(math $i - 1)]
        set -l hxargs $argv[(math $i + 1)..-1]
    else
        set -l paths $argv
        set -l hxargs
    end

    set -l pvar "__mkcfg_p_$name"
    set -l avar "__mkcfg_a_$name"
    set -g $pvar $paths
    set -g $avar $hxargs

    function {$name}config
        set -l pvar "__mkcfg_p_$name"
        set -l avar "__mkcfg_a_$name"
        set -l old $fish_glob_no_error
        set -g fish_glob_no_error 1

        pushd $CONF_DIR >/dev/null
        set -l files
        for p in $$pvar
            set -a files dotfiles/$p
        end
        hx $files $$avar $argv
        popd >/dev/null

        set -g fish_glob_no_error $old
    end
end

mkconfig hx .config/helix/config.toml .config/helix/languages.toml
mkconfig vim '.config/nvim/init.lua .config/nvim/**/*.lua .config/nvim/**/*.vim'
mkconfig zsh '.zshrc .zshenv .config/zsh/*'
mkconfig fish .config/fish/conf.d/aliases.fish
mkconfig i3 .config/i3/config .config/i3status-rust/config.toml
mkconfig sway '.config/sway/common_config .config/sway/(hostname -s) .config/waybar/config.jsonc .config/waybar/*.css'
mkconfig wez '.config/wezterm/config.lua .config/wezterm/*.lua'
mkconfig git '.config/git/extraConfig .config/git/ignore .config/git/*'
mkconfig nix '../mixins/home/common.nix -- **/*.nix'

export MANPAGER='less -M -j5 +Gg'
# PATH=$(printf "%s" "$PATH" | mawk -v RS=: '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')

export {EDITOR,VISUAL}=hx

# set -g fish_cursor_default line
# __fish_cursor_xterm line

# source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
# fish_add_path -p $HOME/.cargo/bin
# fish_add_path -p $HOME/.local/bin
# fish_add_path -p $HOME/.nix-profile/bin

function path
    echo $PATH | sd ' ' '\n'
end
abbr -a vi hx
abbr -a cat bat
function l
    eza --icons --time-style relative --color-scale all --group-directories-first
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
    cd ~/documents/notes && vi todo/TODO.md **/*.md && cd -
end

abbr -a send "wormhole-rs tx"
abbr -a receive "wormhole-rs rx"
abbr -a getsong "ytmdl --dont-transcode --download-archive ~/.cache/ytmdl/archive"
abbr -a wine32 "WINEPREFIX=$HOME/.wine32 wine"
# function ststatus;
#     IFS=$'\n' read -rd '' id uptime start url cpu < < (syncthing cli show system |
#             jq '.myID, .uptime, .startTime, .guiAddressUsed, .cpuPercent' -r)
#     echo -e "ID: $id\nStarted $start $(numbat -e "${uptime}s to human")"
#     echo -e "CPU: $cpu%\nGUI: $(echo $url | sd 127.0.0.1 localhost)"
# end

abbr -a sc systemctl
abbr -a music rmpc
abbr -a m music
function shuffle
    mpc clear && mpc ls | mpc add && mpc shuffle && mpc play
end

abbr -a bp factorio-bp-helper
# function fontcheck
#     FC_DEBUG=4 pango-view -q -t $1 --font=${2:-sans} |&
#         rg -or '$1' 'family: "([^"]+)"' | tail -1
# end

# function nixfind
#     nix-locate --color=always -rt r -t x -t s $@ |
#         sd '/nix/store/[^/\x1b]+' '' | sort
# end

abbr -a nixsize nix-tree
function nixclean
    nix-collect-garbage -d && sudo $(which nix-collect-garbage) -d
end

function _switch
    set uname "$(uname)"
    if [[ $uname == "Darwin" ]]
        then
        set cmd darwin
    else if command -qv nixos-rebuild >/dev/null
        then
        set cmd os
    else
        set cmd home
    end
    nh $cmd switch $CONF_DIR
end
abbr --add switch _switch
abbr --add update switch -u

function give-me-a-ping-vasily
    # One Ping Only...
    echo -n "Ping: "
    ping -qc1 -W1 $1 2>&1 | awk -F/ 'END{ print (/^rtt/? "OK "$5" ms":"FAIL") }'
end
