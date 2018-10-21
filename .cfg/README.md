# Pineapple's Dotfiles

Inspired by [this article](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/) I use a bare git repo to track my dotfiles. That means no symlinks, no duplicates, and no manually moving files around. I simply clone my repo on a new computer, and everything goes where I want. I alias "config" to the repo so I can just `config add .someconfigfile` and `config commit` as if it were a global workspace. Here is a nifty script that clones the repo, backs up all existing dotfiles so they aren't deleted, and sets up the "config" alias, as well as configuring it to only show tracked files:

```
git clone --bare https://github.com/P1n3appl3/dotfiles.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
```
