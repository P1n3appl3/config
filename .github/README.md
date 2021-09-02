# My Setup

![images in the terminal!!!](https://i.imgur.com/6cHqz1s.png)

See more screenshots [here](https://imgur.com/a/QS7Ik7D)

-   **Window manager**: i3
-   **Terminal emulator**: Alacritty/Kitty/Wezterm
-   **Text editor**: Neovim
-   **Browser**: Firefox
-   **Bar**: i3status-rust
-   **Font**: SauceCodePro/FuraCode
-   **GTK Theme** Materia-dark
-   **Program launcher**: rofi
-   **Icons** Papirus/Arc
-   **File Manager**: PCManFM

# Usage

I use a
[bare git repo](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
to track my dotfiles. That means no symlinks, no duplicates, and no manually
moving files around. I simply clone my repo on a new computer, and everything
goes where I want. I also alias "config" to the git command for this repo so I
can just `config add .someconfigfile` and `config commit` as if it were a global
workspace.

Here's a script to grab my dotfiles, back up any conflicts, make the "config"
alias, and hide untracked files:

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
    config checkout 2>&1 | grep "\s+\." | sed 's/^\t//g' | while read -r f; do
        mkdir -p .config_backup/$(dirname $f);
        mv $f .config_backup/$f;
    done
fi;
config checkout
config config status.showUntrackedFiles no
ln -s $HOME/.config $HOME/config
```
