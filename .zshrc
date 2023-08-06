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

# Shortcuts for tweaking dotfiles
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias vimconfig='vi $HOME/.config/nvim/{init.lua,*.lua,*/*.{vim,lua}}'
alias zshconfig='vi $HOME/{.zshrc,.zshenv,.config/zsh/*}'
alias nixconfig='vi $HOME/.config/nix-config/{home-modules/common.nix,**/*.nix}'
alias i3config='vi $HOME/.config/i3/{config,*}'

# Misc.
unsetopt flowcontrol
setopt no_case_glob
WORDCHARS='_.$<>'
TIMEFMT=$'\nreal\t%E\ntime\t%U / %S\ncpu\t%P\nmem\t%M KB
faults\t%F / %R\nwaits\t%c / %w'
export TIME=$TIMEFMT
export MANPAGER='less -M -j5 +Gg'

alias cat=bat
alias l="exa --icons" alias ls="l -l" alias la="l -la"
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
alias nixclean="nix-collect-garbage -d"
function switch {
    command -v nixos-rebuild >/dev/null && {
        sudo true # to prompt for password and not get piped to nom
        cmd="sudo -n nixos-rebuild"
    } || cmd=hm
    eval $cmd switch --flake $HOME/.config/nix-config#$(hostname -s) $@ |& nom
}
alias sc=systemctl
alias music=ncmpcpp
