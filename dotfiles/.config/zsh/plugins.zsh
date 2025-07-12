eval "$(atuin init zsh --disable-up-arrow)"             # History
eval "$(zoxide init zsh --cmd j)"                       # Dir jumper
eval "$(starship init zsh)"                             # Prompt
eval "$(direnv hook zsh)"                               # Env-var manager
eval "$(fzf --zsh | sed -n '/^### completion.zsh/,$p')" # Fuzzy completions
eval "$(pay-respects zsh --nocnf)"                      # Press f

for f in zsh-syntax-highlighting zsh-autosuggestions; do
    source $HOME/.nix-profile/share/$f/$f.zsh
done
