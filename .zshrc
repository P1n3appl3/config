# Add stuff to $PATH
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"

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

# Shortcuts for tweaking dotfiles
alias i3config="vi $HOME/.config/i3/{config,*}"
alias vimconfig="vi $HOME/.config/nvim/{*.lua,lua/*.lua}"
alias zshconfig="vi $HOME/.zshrc"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# I <3 Rust
alias grep=rg
alias cat=bat
alias find=fd
alias l="exa --icons"
alias ls="l -l"
alias la="l -la"
tree() { fd | as-tree; } # TODO: exa once it supports .ignore

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
alias paclist="pacman -Qqs"
alias sc=systemctl
alias music=ncmpcpp
export EDITOR=nvim
export VISUAL=nvim
export TIMEFMT=$'\nreal\t%*E s\nuser\t%*U s\nsys\t%*S s\ncpu\t%P\nmaxmem\t%M MB\nfaults\t%F'

# TODO: handle this stuff in kitty
change_window_title() {
    CURRENT_DIR=$(pwd | sed 's/\/home\/joseph/~/')
    echo -ne "\e]0;$CURRENT_DIR\007"
}
precmd_functions+=(change_window_title)
