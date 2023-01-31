#!/bin/zsh

core=(starship zr-git neovim neovim-symlinks rsync ripgrep fd skim sd exa
    bat ouch git-delta tokei hexyl dog xh choose rm-improved ncdu
    lm_sensors htop bottom bandwhich usbtop procs powertop pacman-cleanup-hook)
dev=(rustup rust-analyzer clang llvm mold lld lldb gdb bear python python-black pyright
    lua stylua lua-language-server shellcheck-bin shfmt prettier taplo-cli github-cli)
desktop=(i3status-rust pipewire pipewire-pulse pipewire-alsa udiskie light
    kitty firefox google-chrome telegram-desktop discord caprine
    lxappearance materia-gtk-theme papirus-icon-theme
    dunst rofi rofi-calc rofimoji
    i3-wm maim clipmenu
    # sway wtype wl-clipboard slurp grim qt5-wayland qt6-wayland
    nerd-fonts-source-code-pro noto-fonts noto-fonts-cjk noto-fonts-emoji
    zathura zathura-pdf-mupdf pavucontrol pamixer mpc mpd mpdris2 ncmpcpp beets mpv imv
    openrazer-meta nautilus sushi via-bin calibre ntfs-3g)
games=(steam lutris osu-lazer-bin slippi-online-appimage dolphin-emu snes9x-gtk
    minecraft-launcher pacmc fabric-installer xdelta3)
tools=(obs-studio ffmpeg sox imagemagick krita inkscape kdenlive
    helio-workstation-bin musescore blender godot freecad python-solidpython
    kicad kicad-library pcbdraw gtkwave saleae-logic2 openocd logisim)
# find an audacity fork

set -exu
cd

read "host?Pick a hostname: "
sudo hostnamectl hostname $host

mkdir Documents Downloads Games Images Images/screenshots Music Videos test

# secrets + env
mkdir -p .ssh
bw login --trust josephryan3.14@gmail.com
bw get notes ssh_private >.ssh/id_rsa
bw get notes ssh_public >.ssh/id_rsa.pub
# TODO: replace xprofile with .config/environment.d once supported
echo export OPENWEATHERMAP_API_KEY=$(bw get notes openweathermap) \
    >>.xprofile
# TODO: lastpass with attachment downloading michaelfbryan for gpg
cat >>.xprofile <<EOF
# export QT_QPA_PLATFORM=wayland
# export MOZ_ENABLE_WAYLAND=1
# about:support -> Window Protocol should say wayland
# about:config gfx.webrender.compositor.force-enabled = true
# about:config ui.systemUsesDarkTheme = 1
EOF

cat >.xprofile <<EOF
#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

[ -f $sysresources ] && xrdb -merge $sysresources
[ -f $sysmodmap ] && xmodmap $sysmodmap
[ -f "$userresources" ] && xrdb -merge "$userresources"
[ -f "$usermodmap" ] && xmodmap "$usermodmap"

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

[ -f ~/.xprofile ] && . ~/.xprofile

exec i3
EOF

# get config files
curl -L https://raw.github.com/P1n3appl3/config/master/.config/scripts/setup.sh | sh
ln -s desktop .config/sway/current_device

# Time
.config/scripts/timezone.sh
timedatectl set-ntp true
timedatectl status
# timedatectl timesync-status
sudo hwclock --systohc

# AUR/pacman
curl -L $(curl -s https://api.github.com/repos/Morganamilo/paru/releases/latest |
    grep "browser.*x86_64" | cut -d\" -f4) | tar --zstd -xf - paru
./paru -S paru-bin rate-mirrors-bin
rm paru
sudo chown joseph /etc/pacman.d/mirrorlist
rate-mirrors --save /etc/pacman.d/mirrorlist arch

paru -S ${core[@]}
paru -S ${dev[@]}

# Neovim
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    $HOME/.local/share/nvim/site/pack/paqs/start/paq-nvim
vi --headless +PaqInstall +q
vi --headless +PaqList +q

paru -S ${desktop[@]}
paru -S ${games[@]}
paru -S ${tools[@]}
