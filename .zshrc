export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Load other configs
my_configs=(keybinds completion fuzzy history terminal)
for f in $my_configs; do source $HOME/.config/zsh/$f.zsh; done

eval "$(atuin init zsh --disable-up-arrow)" # History
eval "$(zoxide init zsh --cmd j)"           # Dir jumper
eval "$(starship init zsh)"                 # Prompt

source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
source $HOME/.nix-profile/share/fzf/completion.zsh
for f in zsh-syntax-highlighting zsh-autosuggestions; do
    source $HOME/.nix-profile/share/$f/$f.zsh
done

# Shortcuts for tweaking dotfiles
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias vimconfig='vi $HOME/.config/nvim/{init.lua,*.lua,*/*.{vim,lua}}'
alias zshconfig='vi $HOME/.zshrc $HOME/.config/zsh/*'
alias nixconfig='vi $HOME/.config/nixpkgs/{home.nix,*}'
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
function pacsize {
    paru -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
}
function pacclean { paru -Qtdq | paru -Rns -; }
alias nixclean="nix-collect-garbage -d"
alias sc=systemctl
alias music=ncmpcpp
