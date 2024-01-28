{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    itch
    ludusavi

    osu-lazer-bin
    clonehero # TODO: make ~/.clonehero point to games subvol

    ttyper
    nethack
    openttd
    space-cadet-pinball
    openspades

    punes snes9x-gtk mupen64plus dolphin-emu yuzu-mainline # simple64
    sameboy mgba melonDS
  ];
}
