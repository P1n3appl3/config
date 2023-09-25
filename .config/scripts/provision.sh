#!/usr/bin/env bash

dev=(neovim neovim-symlinks rsync pacman-cleanup-hook)
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

echo -n "Pick a hostname: "
read -r host
sudo hostnamectl hostname "$host"

mkdir Documents Downloads Games Images Images/screenshots Music Videos test

# secrets + env
mkdir -p .ssh
rbw config set email josephryan3.14@gmail.com
rbw get ssh_private >.ssh/id_rsa
rbw get ssh_public >.ssh/id_rsa.pub
chmod 700 .ssh
chmod 644 .ssh/id_rsa.pub
chmod 600 .ssh/id_rsa
echo export OPENWEATHERMAP_API_KEY=$(rbw get openweathermap) \
    >>.xprofile
cat >>.xprofile <<EOF
# export QT_QPA_PLATFORM=wayland
# export MOZ_ENABLE_WAYLAND=1
# about:support -> Window Protocol should say wayland
# about:config gfx.webrender.compositor.force-enabled = true
# about:config ui.systemUsesDarkTheme = 1
EOF

cat >.xprofile <<'EOF'
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

paru -S "${dev[@]}"

# get config files
curl -L https://raw.github.com/P1n3appl3/config/main/.config/scripts/setup.sh | sh

paru -S "${desktop[@]}"
paru -S "${games[@]}"
paru -S "${tools[@]}"
