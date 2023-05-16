# Load other configs
my_configs=(keybinds completion fuzzy history terminal)
for f in $my_configs; do source $HOME/.config/zsh/$f.zsh; done

eval "$(atuin init zsh --disable-up-arrow)" # History
eval "$(zoxide init zsh --cmd j)"           # Dir jumper
eval "$(starship init zsh)"                 # Prompt
eval "$(direnv hook zsh)"
eval "$(nix-your-shell zsh)"

# TODO: remove when MercuryTechnologies/nix-your-shell adds this
export __ETC_PROFILE_NIX_SOURCED=1

source $HOME/.nix-profile/share/fzf/completion.zsh
for f in zsh-syntax-highlighting zsh-autosuggestions; do
    source $HOME/.nix-profile/share/$f/$f.zsh
done

# Shortcuts for tweaking dotfiles
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias vimconfig='vi $HOME/.config/nvim/{init.lua,*.lua,*/*.{vim,lua}}'
alias zshconfig='vi $HOME/{.zshrc,.zshenv,.config/zsh/*}'
alias nixconfig='vi $HOME/.config/home-manager/{home.nix,**/*.*}'
alias i3config='vi $HOME/.config/i3/{config,*}'

# Misc.
unsetopt flowcontrol
setopt no_case_glob
WORDCHARS='_.$<>'
TIMEFMT=$'\nreal\t%*E s\nuser\t%*U s\nsys\t%*S s\ncpu\t%P\nmem\t%M MB\nfaults\t%F'

alias cat=bat
alias dig=dog
alias l="exa --icons"
alias ls="l -l"
alias la="l -la"
alias tree="l -T --git-ignore"
function cd { echo "you aliased that to j silly…" && j $@; }
alias o=xdg-open
alias c=clear
alias please=sudo
alias fuck=killall
alias paclist="paru -Qqs"
alias pacfind="paru -Fy"
function pacsize {
    paru -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
}
function pacclean { paru -Qtdq | paru -Rns -; }
alias hm=home-manager
alias nixlist='home-manager packages'
function nixfind {
    nix-locate --color=always -t r -t x --top-level $@ |
        sd '/nix/store/[^/\x1b]+' '' | sort
}
alias nixsize='nix-tree /nix/var/nix/profiles/per-user/$USER/home-manager'
alias nixclean="nix-collect-garbage -d"
function switch { home-manager switch $@ |& nom; }
alias sc=systemctl
alias music=ncmpcpp
