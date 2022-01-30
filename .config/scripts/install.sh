#!/bin/zsh

set -exu

# Don't need sudo for stuff if this is a livedisk since you're already root

read "disk?Input disk name (/dev/<???>):"
sudo parted /dev/$disk <<EOF
mklabel gpt
mkpart ESP fat32 1MiB 301MiB
set 1 esp on
mkpart ROOT ext4 301MiB 100%
EOF
boot=$(sudo fdisk -l | grep "/dev/$disk.*EFI" | cut -d' ' -f1)
main=$(sudo fdisk -l | grep "/dev/$disk.*Linux" | cut -d' ' -f1)

sudo mkfs.fat -F 32 -n boot $boot
sudo mkfs.ext4 -L main $main

sudo mkdir /mnt
sudo mount $main /mnt
sudo mkdir /mnt/boot
sudo mount $boot /mnt/boot

sudo pacstrap /mnt base linux-zen linux-firmware amd-ucode base-devel \
    dhcpcd openssh zsh git lastpass-cli
genfstab -U /mnt | sudo tee -a /mnt/etc/fstab >/dev/null

less /mnt/etc/fstab
read "pass?Pick a password: "

sudo tee /mnt/etc/resolv.conf >/dev/null <<EOF
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 8.8.8.8
nameserver 8.8.4.4
options timeout:1
EOF
sudo chattr +i /mnt/etc/resolv.conf

sudo arch-chroot /mnt <<END
passwd
$pass
$pass
useradd -m joseph -s /bin/zsh -G wheel
passwd joseph
$pass
$pass

echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen
locale-gen
localectl set-locale LANG=en_US.UTF-8

mkdir -p /etc/systemd/system/getty@tty1.service.d/
cat >/etc/systemd/system/getty@tty1.service.d/autologin.conf <<"EOF"
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin joseph
EOF

bootctl install
systemctl enable systemd-boot-update
cat >/boot/loader/entries/arch.conf <<EOF
title   Arch Linux
linux   /vmlinuz-linux-zen
initrd  /amd-ucode.img
initrd  /initramfs-linux-zen.img
options root=LABEL=main rw
EOF

systemctl enable systemd-timesyncd
systemctl enable dhcpcd
systemctl enable sshd

dd if=/dev/zero of=/swapfile bs=1M count=512 status=progress
chmod 600 /swapfile
mkswap /swapfile
END

# Maybe need extra kernel param
# vt.global_cursor_default=0

# Manually mount windows ESP and yoink EFI/Microsoft into new ESP
# Manually uncomment %wheel in /etc/sudoers
# Manually edit /etc/pacman.conf to uncomment/include:
# Color
# VerbosePkgLists
# ParallelDownloads = 5
# ILoveCandy
