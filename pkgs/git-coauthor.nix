{ writeShellApplication, fzf, choose }: writeShellApplication {
  name = "git-coauthor";
  runtimeInputs = [ fzf choose ];
  # TODO: helptext
  text = ''
    selection="$(git shortlog -nse | choose 1.. | rg -Fv "$(git config user.email)" | fzf)"
    git commit --amend --no-edit --trailer --if-missing "Co-authored-by: $selection"
  '';
}
