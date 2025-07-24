{ writeShellApplication, git-filter-repo, blahaj, gay }: writeShellApplication {
  name = "git-undeadname";
  runtimeInputs = [ git-filter-repo blahaj gay ];
  text = ''
    read -r -p "please give me your new name: " newname
    for _ in {1..3}; do sleep 0.25 && echo -n "."; done
    echo -n " wow " && sleep 0.25
    echo -n "\"$newname\" " | gay -tu
    echo "is such a pretty name! i love it ^.^" && sleep 0.5
    read -rs -p "now could i have your old email (dw i wont look >.<): " oldemail
    echo ""
    read -r -p "and finally enter your new email (or leave blank if unchanged): " newemail

    if [[ -z "$newemail" ]]; then
        newemail="$oldemail"
    fi

    mailmap=$(mktemp)
    echo "$newname <$newemail> <$oldemail>" >"$mailmap"
    git filter-repo --force --mailmap "$mailmap"
    blahaj -s
    rm "$mailmap"

    echo ""
    echo "Congrats! Your name has been updated in all commits of this repo."
    echo "If you force-push it should update in the remote, but only do this"
    echo "if you understand the consequences of rewriting history (such as"
    echo "breaking commit signatures and open PR's)!"
    echo -e "See \e[4m\e]8;;https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository#side-effects-of-rewriting-history\e\\here\e]8;;\e\\\\\e[0m for more details."
  '';
}
