# Add language stuff to path
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
    > ~/.config/zr.zsh
    # zdharma/fast-syntax-highlighting \
    # b4b4r07/enhancd \
    # changyuheng/zsh-interactive-cd \
fi; source ~/.config/zr.zsh

# If no command is given, try to cd
setopt AUTO_CD
alias -g ...='../..'

# Shortcuts for tweaking dotfiles
alias i3config="vi $HOME/.config/i3/*"
alias vimconfig="vi $HOME/.config/nvim/*.vim"
alias zshconfig="vi $HOME/.zshrc"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# I <3 Rust
alias grep=rg
alias cat=bat
alias find=fd
alias l=lsd
alias ls="exa -l --icons"
alias la="exa -la --icons"
alias tree="exa --tree --icons"
export TERMINAL=alacritty

# Fuzzy searching
source /usr/share/skim/key-bindings.zsh
export SKIM_DEFAULT_COMMAND="fd . -L" # because I symlink ~/config to ~/.config
export SKIM_CTRL_T_COMMAND="$SKIM_DEFAULT_COMMAND --type f"
export SKIM_ALT_C_COMMAND="$SKIM_DEFAULT_COMMAND --type d ~"

# Misc.
alias o=xdg-open
alias c=clear
# alias so=source
alias please=sudo
alias fuck=killall
alias paclist="pacman -Qqs"
alias sc=systemctl
alias music=ncmpcpp
export EDITOR=nvim
export VISUAL=nvim

# Parallelize Make
alias make="make -j$(nproc)"

change_window_title() {
    #LASTCMD=$(history | cut -c8- | tail -n 1);
    CURRENT_DIR=$(pwd | sed 's/\/home\/joseph/~/')
    echo -ne "\e]0;$CURRENT_DIR\007";
}

precmd_functions+=(change_window_title)
