{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    itch
    ludusavi

    osu-lazer-bin
    clonehero # make ~/.clonehero subvolume

    nethack
    openttd
    space-cadet-pinball
    openspades

    dolphin-emu snes9x-gtk
  ];
}
