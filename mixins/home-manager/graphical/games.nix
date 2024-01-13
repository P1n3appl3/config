{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    itch
    ludusavi

    osu-lazer-bin
    clonehero # make ~/.clonehero point to games subvol

    ttyper
    nethack
    openttd
    space-cadet-pinball
    openspades

    dolphin-emu snes9x-gtk
  ];
}
