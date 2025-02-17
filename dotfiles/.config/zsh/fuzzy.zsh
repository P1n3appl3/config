export FZF_DEFAULT_OPTS="--reverse --bind=ctrl-z:ignore \
  --preview-window=down --height=60% --inline-info \
  --bind 'ctrl-p:change-preview-window(hidden|down)' \
  --bind ctrl-r:first --bind alt-up:first --bind alt-down:last \
  --bind shift-up:preview-page-up --bind shift-down:preview-page-down \
  --bind ctrl-d:half-page-down --bind ctrl-u:half-page-up \
  --color=bg+:#313244,spinner:#f5e0dc,header:#f38ba8 \
  --color=fg:#cdd6f4,fg+:#cdd6f4,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,prompt:#cba6f7,hl:#f38ba8,hl+:#f38ba8 \
 "
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir j ji tree"

__fzf() {
    setopt localoptions pipefail
    local item
    fd -H --mount --color=always --type $1 |
        fzf --multi --height=80% --ansi \
            --preview "~/.config/zsh/preview.sh {}" \
            --bind "ctrl-/:reload(fd . / --mount -t$1)" \
            --bind "ctrl-h:reload(fd . ~ -H --mount -t$1)" \
            --bind "ctrl-w:reload(fd --mount -t$1)" |
        while read item; do
            echo -n "${(q)item} " # https://github.com/mvdan/sh/issues/960
        done
    local ret=$? && echo && return $ret
}
fzf-file-widget() {
    LBUFFER="${LBUFFER}$(__fzf f)"
    local ret=$? && zle reset-prompt && return $ret
}
fzf-dir-widget() {
    LBUFFER="${LBUFFER}$(__fzf d)"
    local ret=$? && zle reset-prompt && return $ret
}
zle -N fzf-file-widget && bindkey '^F' fzf-file-widget
zle -N fzf-dir-widget && bindkey '^G' fzf-dir-widget

_fzf_compgen_path() { fd -H --mount . "$1"; }
_fzf_compgen_dir() { fd -H --mount -td . "$1"; }
_fzf_comprun() {
    local command=$1 && shift
    case "$command" in
    j) fzf --preview "eza --icons {}" "$@" ;;
    export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
    ssh) fzf --preview 'give-me-a-ping-vasily {}; dog --color=always {}' "$@" ;;
    *) fzf "$@" ;;
    esac
}
