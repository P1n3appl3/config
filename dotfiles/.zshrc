# Load other configs
my_configs=(keybinds completion plugins fuzzy history terminal aliases)
for f in $my_configs; do source $HOME/.config/zsh/$f.zsh; done
local extra=$HOME/.config/zsh/extra.zsh && test -f $extra && source $extra

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
mkconfig hypr '.config/hypr/{hyprland.conf,*.conf}'

# Misc.
unsetopt flowcontrol
setopt no_case_glob
TIMEFMT=$'\nreal\t%E\ntime\t%U / %S\ncpu\t%P\nmem\t%M KB\nfaults\t%F / %R\nwaits\t%c / %w'
export TIME=$TIMEFMT
export MANPAGER='less -M -j5 +Gg'
function path { echo $path | sd ' ' '\n'; }
PATH=$(printf "%s" "$PATH" | mawk -v RS=: '!a[$1]++ { if (NR > 1) printf RS; printf $1 }')
