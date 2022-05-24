I use a [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles) to
track my dotfiles. I also alias `config` to the git command for this repo so I
can just `config add .someconfigfile` and `config commit` as if it were a global
workspace. [This script](/.config/scripts/setup.sh) grabs my dotfiles and sets
up the alias, backing up any conflicts.
