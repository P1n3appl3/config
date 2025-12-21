{ writeShellApplication, fzf, choose }: writeShellApplication {
  name = "git-coauthor";
  runtimeInputs = [ fzf choose ];
  # TODO: helptext
  text = ''
    selection="$(git shortlog -nse | choose 1.. | fzf)"
    if [ $? -eq 0 ]; then
      git commit --amend --no-edit --trailer "Co-authored-by: $selection"
    fi
  '';
  meta.broken = true;
}
