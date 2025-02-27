unalias run-help && autoload -Uz run-help && alias help=run-help

function path { echo $path | sd ' ' '\n'; }
alias cat=bat
alias l="eza --icons --time-style relative --color-scale all --group-directories-first"
alias ls="l -l" alias la="l -la"
alias tree="l -T --git-ignore"
alias o=xdg-open
alias c=clear
alias sudo="sudo " # trailing space for alias expansion
alias please="sudo "
alias fuck=killall
function note { cd ~/documents/notes && vi todo/TODO.md **/*.md && cd -; }
alias wine32="WINEPREFIX=$HOME/.wine32 wine"
alias send="wormhole-rs tx"
alias receive="wormhole-rs rx"
alias getsong="ytmdl --dont-transcode --download-archive ~/.cache/ytmdl/archive"
function ststatus {
    IFS=$'\n' read -rd '' id uptime start url cpu < \
        <(syncthing cli show system |
            jq '.myID, .uptime, .startTime, .guiAddressUsed, .cpuPercent' -r)
    echo -e "ID: $id\nStarted $start $(numbat -e "${uptime}s to human")"
    echo -e "CPU: $cpu%\nGUI: $(echo $url | sd 127.0.0.1 localhost)"
}

alias sc=systemctl
alias music=ncmpcpp
function fontcheck {
    FC_DEBUG=4 pango-view -q -t $1 --font=${2:-sans} |&
        rg -or '$1' 'family: "([^"]+)"' | tail -1
}

alias hm=home-manager
alias nixlist='hm packages'
function nixfind {
    nix-locate --color=always -rt r -t x -t s --top-level $@ |
        sd '/nix/store/[^/\x1b]+' '' | sort
}
alias nixsize=nix-tree
function nixclean { nix-collect-garbage -d && sudo $(which nix-collect-garbage) -d; }
function switch {
    # TODO: change when nh darwin support releases
    if [[ `uname` == "Darwin" ]]; then
        darwin-rebuild switch --flake ~/config $@
    else
      command -v nixos-rebuild >/dev/null &&
        { cmd="os switch -H"; } ||
          cmd="home switch -c"
      eval nh $cmd $(hostname -s) -a $CONF_DIR $@
    fi
}
alias update="switch -u"
