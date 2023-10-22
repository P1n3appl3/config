# TODO: fix https://github.com/crossterm-rs/crossterm/issues/685 so ctrl+backspace
# works in atuin: https://github.com/atuinsh/atuin/issues/941
eval "$(atuin init zsh --disable-up-arrow)" # History
eval "$(zoxide init zsh --cmd j)"           # Dir jumper
eval "$(starship init zsh)"                 # Prompt

source $HOME/.nix-profile/share/fzf/completion.zsh
for f in zsh-syntax-highlighting zsh-autosuggestions; do
    source $HOME/.nix-profile/share/$f/$f.zsh
done

# _zsh_autosuggest_strategy_atuin() {
#     suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
# }
# https://pastebin.com/RXxU6rT4
# https://github.com/atuinsh/atuin/issues/68#issuecomment-1582815247
# ZSH_AUTOSUGGEST_STRATEGY=atuin

# TODO: custom command-not-found, edit distance, nix-index, maybe pacman

# TODO: remove when https://github.com/direnv/direnv/issues/68 lands
copy_function() {
    test -n "$(declare -f "$1")" || return
    eval "${_/$1/$2}"
}
copy_function _direnv_hook _direnv_hook__old
_direnv_hook() {
    _direnv_hook__old "$@" 2> >(awk '{if (length >= 10) \
        { sub("^direnv: export.*", "direnv: export "NF" environment variables")}}1')
    wait
}

eval "$(direnv hook zsh)"
