# Load other configs
my_configs=(keybinds completion plugins fuzzy history terminal theme aliases)
for f in $my_configs; do source $HOME/.config/zsh/$f.zsh; done
local extra=$HOME/.config/zsh/extra.zsh && test -f $extra && source $extra

# Shortcuts for tweaking dotfiles
alias config='git -C $CONF_DIR'
alias reload='unset __HM_SESS_VARS_SOURCED; exec zsh'
function mkconfig {
    eval "function ${1}config { pushd -q $CONF_DIR; vi dotfiles/$2 ${@:3}; popd -q }"
}
mkconfig vim '.config/nvim/{init.lua,*.lua,*/*.lua}'
mkconfig zsh '{.zshrc,.zshenv,.config/zsh/*}'
mkconfig nix '../mixins/home/common.nix' '**/*.nix'
mkconfig i3 '.config/{i3/config,i3status-rust/*}'
mkconfig sway '.config/{sway/{common_config,`hostname -s`},i3status-rust/*}'
mkconfig git '.config/git/{extraConfig,ignore,*}'

# Misc.
unsetopt flowcontrol
setopt no_case_glob
TIMEFMT=$'\nreal\t%E\ntime\t%U / %S\ncpu\t%P\nmem\t%M KB\nfaults\t%F / %R\nwaits\t%c / %w'
export TIME=$TIMEFMT
export MANPAGER='less -M -j5 +Gg'
PATH=$(printf "%s" "$PATH" | mawk -v RS=: '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
