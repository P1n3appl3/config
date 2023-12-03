{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    osu-lazer-bin
    clonehero # make ~/.clonehero subvolume
    ludusavi
    dolphin-emu snes9x-gtk
    nethack
    openttd
    itch
  ];
}
