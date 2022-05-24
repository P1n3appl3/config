# Add stuff to $PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/fuchsia/.jiri_root/bin"
source ~/fuchsia/scripts/fx-env.sh
export FUCHSIA_BUILD_DIR="$FUCHSIA_DIR/out/default"
unset -f fd

# Prompt
eval "$(starship init zsh)"

# Load plugins
if [[ ! -f ~/.config/zr.zsh ]] || [[ ~/.zshrc -nt ~/.config/zr.zsh ]]; then
    zr \
        zsh-users/zsh-autosuggestions \
        zsh-users/zsh-syntax-highlighting \
        ohmyzsh/ohmyzsh.git/lib/completion.zsh \
        ohmyzsh/ohmyzsh.git/lib/history.zsh \
        ohmyzsh/ohmyzsh.git/lib/key-bindings.zsh \
        lotabout/skim.git/shell/key-bindings.zsh \
        lotabout/skim.git/shell/completion.zsh \
        >~/.config/zr.zsh
fi
source ~/.config/zr.zsh
autoload -U compinit && compinit -c

# Shortcuts for tweaking dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias i3config="vi $HOME/.config/i3/{config,*}"
alias vimconfig="vi $HOME/.config/nvim/{*.lua,lua/*.lua}"
alias zshconfig="vi $HOME/.zshrc"
alias swayconfig="vi $HOME/.config/sway/{config,*}"

# I <3 Rust
alias cat=bat
alias grep=rg
alias find=fd
alias dig=dog
alias l="exa --icons"
alias ls="l -l"
alias la="l -la"
alias tree="l -T --git-ignore"
# alias rm=rip

# Fuzzy searching
export SKIM_DEFAULT_COMMAND="fd . -H --one-file-system"
export SKIM_CTRL_T_COMMAND="$SKIM_DEFAULT_COMMAND --type f"
export SKIM_ALT_C_COMMAND="$SKIM_DEFAULT_COMMAND --type d ~"

# Misc.
alias o=xdg-open
alias c=clear
alias so=source
alias please=sudo
alias fuck=killall
alias paclist="paru -Qqs"
function pacsize {
    paru -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
}
function pacclean {
    paru -Qtdq | paru -Rns -
}
alias sc=systemctl
alias music=ncmpcpp
export EDITOR=nvim
export VISUAL=nvim
export TIMEFMT=$'\nreal\t%*E s\nuser\t%*U s\nsys\t%*S s\ncpu\t%P\nmaxmem\t%M MB\nfaults\t%F'
export TEMPDIR=/tmp
