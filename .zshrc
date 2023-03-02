export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Load other configs
eval "$(starship init zsh)" # Prompt
# TODO: when acting like cd, completion should just be for dirs not files
# maybe https://github.com/ajeetdsouza/zoxide/issues/513 fixes?
eval "$(zoxide init --cmd j zsh)" # Dir jumper
eval "$(atuin init zsh --disable-up-arrow)" # History

for f in $HOME/.config/zsh/*.zsh; do
    source $f
done

if [[ ! -f ~/.config/zr.zsh ]] || [[ ~/.zshrc -nt ~/.config/zr.zsh ]]; then
    zr \
        zsh-users/zsh-syntax-highlighting \
        zsh-users/zsh-autosuggestions \
        junegunn/fzf.git/shell/completion.zsh \
        >~/.config/zr.zsh
fi
source ~/.config/zr.zsh

# Shortcuts for tweaking dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias i3config="vi $HOME/.config/i3/{config,*}"
alias vimconfig="vi $HOME/.config/nvim/{init.lua,*.lua,*/*.{vim,lua}}"
alias zshconfig="vi $HOME/.zshrc $HOME/.config/zsh/*"

# Misc.
export {EDITOR,VISUAL}=nvim
unsetopt flowcontrol
setopt no_case_glob
WORDCHARS='_.$<>'
TIMEFMT=$'\nreal\t%*E s\nuser\t%*U s\nsys\t%*S s\ncpu\t%P\nmem\t%M MB\nfaults\t%F'

alias cat=bat
alias dig=dog
# TODO: add hyperlinks to exa or switch to lsd once this is resolved:
# https://github.com/Peltoche/lsd/issues/192#issuecomment-1416334853
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
function pacclean {
    paru -Qtdq | paru -Rns -
}
alias sc=systemctl
alias music=ncmpcpp
