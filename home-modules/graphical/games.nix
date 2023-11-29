{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    osu-lazer-bin
    clonehero
    ludusavi
    dolphin-emu snes9x-gtk
    nethack
    openttd
    itch
  ];
}
