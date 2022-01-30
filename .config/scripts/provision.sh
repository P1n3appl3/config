#!/bin/zsh

core=(starship zr-git neovim neovim-symlinks ccache rsync ripgrep fd skim sd exa
    bat ouch-bin git-delta tokei hexyl dog xh choose-bin rm-improved
    lm_sensors htop bottom bandwhich usbtop procs powertop pacman-cleanup-hook)
dev=(rustup sccache rust-analyzer cargo-edit clang llvm lld lldb gdb bear
    python python-black pyright lua stylua-bin lua-language-server bash-language-server)
desktop=(sway i3status-rust pipewire pipewire-pulse pipewire-alsa udiskie light
    kitty firefox google-chrome telegram-desktop discord caprine
    lxappearance materia-gtk-theme papirus-icon-theme
    nerd-fonts-source-code-pro noto-fonts noto-fonts-cjk noto-fonts-emoji
    openrazer-meta rofi rofimoji rofi-calc nautilus sushi
    zathura zathura-pdf-mupdf pavucontrol pamixer mpc mpd mpdris2 ncmpcpp beets mpv imv
    via-bin calibre ntfs-3g udiskie nvidia-utils)
games=(steam lutris osu-lazer-bin slippi-online-appimage dolphin-emu snes9x-gtk
    minecraft pacmc fabric-installer dwarffortress dwarftherapist xdelta3)
tools=(obs-studio ffmpeg sox imagemagick krita inkscape kdenlive
    lmms blender godot freecad python-solidpython
    kicad kicad-library pcbdraw gtkwave saleae-logic2 openocd logisim)
# find an audacity fork

set -exu
cd

read "host?Pick a hostname: "
sudo hostnamectl hostname $host

mkdir Documents Downloads Games Images Music Videos test

# secrets
lpass login --trust josephryan3.14@gmail.com
lpass show --notes ssh_private >.ssh/id_rsa
lpass show --notes ssh_public >.ssh/id_rsa.pub
mkdir -p .config/environment.d
echo OPENWEATHERMAP_API_KEY=$(lpass show --notes openweathermap) \
    >.config/environment.d/weather.conf
# TODO: lastpass with attachment downloading michaelfbryan for gpg

# get dotfiles
curl -L https://raw.github.com/P1n3appl3/dotfiles/master/.config/setup.sh | sh

# Time
.config/scripts/timezone.sh
timedatectl set-ntp true
timedatectl status
# timedatectl timesync-status
hwclock --systohc

# AUR/pacman
curl -L $(curl -s https://api.github.com/repos/Morganamilo/paru/releases/latest |
    rg "browser.*x86_64" | cut -d\" -f4) | tar -axf - paru
./paru -S paru-bin rate-mirrors-bin
rm paru
rate-mirrors --save /etc/pacman.d/mirrorlist arch

paru -S ${core[@]} ${dev[@]} ${desktop[@]} ${games[@]} ${tools[@]}

# Neovim
git clone --depth=1 https://github.com/savq/paq-nvim.git \
    $HOME/.local/share/nvim/site/pack/paqs/start/paq-nvim
vi --headless +PaqInstall +PaqList +q

# minecraft
minecraft_mods=(
    G1epq3jN # advancement info
    1IjD5062 # continuity
    P7dR8mSH # fabric api
    349239   # carpet
    Orvt0mRa # indium
    308892   # litematica
    gvQqBUqZ # lithium
    244260   # minihud
    mOgUt4GM # mod menu
    296468   # no fog
    hEOCdOgW # phosphor
    AANobbMI # sodium
    297344   # tweakeroo
    225608   # world edit
)
fabric-installer client -dir .minecraft
pacmc init
for mod in $minecraft_mods; do
    pacmc install $mod
done

#TODO
# etc host localhost make sure gets set
