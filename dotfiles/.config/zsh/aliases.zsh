unalias run-help && autoload -Uz run-help && alias help=run-help

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
    command -v nixos-rebuild >/dev/null && {
        sudo true
        cmd="sudo -n nixos-rebuild"
    } || cmd=hm
    eval $cmd switch --flake config#$(hostname -s) $@
}
