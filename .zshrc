source ~/.zplug/init.zsh

POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir_writable dir vcs newline)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs)

zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme
zplug "lib/completion", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/key-bindings", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-autosuggestions"
# zplug "changyuheng/zsh-interactive-cd"
# zplug "zdharma/fast-syntax-highlighting", defer:3
# zplug "b4b4r07/enhancd", use:enhancd.sh
! zplug check && zplug install
zplug load

autoload -U compinit; compinit -d ~/.zcompdump

# Change autosuggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'

# If no command is given, try to cd
setopt AUTO_CD
alias -g ...='../..'

# Add language stuff to path
export PATH="$PATH:$HOME/.cargo/bin"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export PATH="$PATH":"$HOME/.local/bin"

# Shortcuts for tweaking dotfiles
alias i3config="vi $HOME/.config/i3/*"
alias vimconfig="vi $HOME/.config/nvim/*.vim"
alias zshconfig="vi $HOME/.zshrc"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# I <3 Rust
alias grep=rg
alias cat=bat
alias find=fd
alias ls=lsd
export TERMINAL=alacritty

# Misc.
alias o=xdg-open
alias c=clear
alias so=source
alias please=sudo
alias pac="pakku -Syu"
alias paclist="pacman -Qqs"
alias sc=systemctl
alias music=ncmpcpp
export EDITOR=nvim
export VISUAL=nvim

# FZF
source /usr/share/fzf/key-bindings.zsh
export FZF_DEFAULT_COMMAND="fd . -L" # because I symlink ~/config to ~/.config
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND --type f ~"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d ~"

# Parallelize Make
alias make="make -j$(nproc)"

# Change terminal title to the current directory
precmd() {
    #LASTCMD=$(history | cut -c8- | tail -n 1);
    CURRENT_DIR=$(pwd | sed 's/\/home\/joseph/~/')
    echo -ne "\e]0;$CURRENT_DIR\007";
}

# Turn off unicode stuff if we're in a TTY
case $(tty) in
  (/dev/tty[1-9])
      prompt_powerlevel9k_teardown;
      PROMPT='%~ -> ';
      alias ls=exa;; esac
# neofetch
