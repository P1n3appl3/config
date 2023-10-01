# Load other configs
my_configs=(keybinds completion fuzzy history terminal)
for f in $my_configs; do source $HOME/.config/zsh/$f.zsh; done
local extra=$HOME/.config/zsh/extra.zsh
test -f $extra && source $extra

eval "$(atuin init zsh --disable-up-arrow)" # History
eval "$(zoxide init zsh --cmd j)"           # Dir jumper
eval "$(starship init zsh)"                 # Prompt
eval "$(direnv hook zsh)"

source $HOME/.nix-profile/share/fzf/completion.zsh
for f in zsh-syntax-highlighting zsh-autosuggestions; do
    source $HOME/.nix-profile/share/$f/$f.zsh
done

# TODO: command-not-found, edit distance, nix-index, maybe pacman

# Shortcuts for tweaking dotfiles
alias config='git -C $CONF_DIR'
alias reload='unset __HM_SESS_VARS_SOURCED; exec zsh'
function mkconfig {
    eval "function ${1}config { cd $CONF_DIR; vi $CONF_DIR/dotfiles/$2 ${@:3}; cd -}"
}
mkconfig vim '.config/nvim/{init.lua,*.lua,*/*.{vim,lua}}'
mkconfig zsh '{.zshrc,.zshenv,.config/zsh/*}'
mkconfig nix '../{home-modules/common.nix,**/*.nix}'
mkconfig i3 '.config/i3/{config,*}'

# Misc.
unsetopt flowcontrol
setopt no_case_glob
WORDCHARS='_.$<>'
TIMEFMT=$'\nreal\t%E\ntime\t%U / %S\ncpu\t%P\nmem\t%M KB
faults\t%F / %R\nwaits\t%c / %w'
export TIME=$TIMEFMT
export MANPAGER='less -M -j5 +Gg'

# TODO: remove when https://github.com/direnv/direnv/issues/68 lands
copy_function() {
    test -n "$(declare -f "$1")" || return
    eval "${_/$1/$2}"
}
copy_function _direnv_hook _direnv_hook__old
_direnv_hook() {
    _direnv_hook__old "$@" 2> >(awk '{if (length >= 10) \
        { sub("^direnv: export.*", "direnv: export "NF" environment variables")}}1')
    wait
}

alias cat=bat
alias l="eza --icons --time-style relative" alias ls="l -l" alias la="l -la"
alias tree="l -T --git-ignore"
alias o=xdg-open
alias c=clear
alias sudo="sudo " # for alias expansion
alias please=sudo
alias fuck=killall
alias paclist="paru -Qqs"
alias pacfind="paru -Fy"
function pacsize {
    paru -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
}
function pacclean { paru -Qtdq | paru -Rns -; }
alias hm=home-manager
alias nixlist='hm packages'
function nixfind {
    nix-locate --color=always -t r -t x --top-level $@ |
        sd '/nix/store/[^/\x1b]+' '' | sort
}
alias nixsize=nix-tree
function nixclean { nix-collect-garbage -d && sudo $(which nix-collect-garbage) -d; }
function switch {
    command -v nixos-rebuild >/dev/null && {
        sudo true # to prompt for password and not get piped to nom
        cmd="sudo -n nixos-rebuild"
    } || cmd=hm
    eval $cmd switch --flake config#$(hostname -s) $@ |& nom
}
alias sc=systemctl
alias music=ncmpcpp
function fontcheck {
    FC_DEBUG=4 pango-view -q -t $1 --font=${2:-sans} |&
        rg -or '$1' 'family: "([^"]+)"' | tail -1
}
