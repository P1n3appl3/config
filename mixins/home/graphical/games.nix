{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    # itch # TODO: reenable when butler is fixed
    ludusavi

    osu-lazer-bin
    clonehero # TODO: make ~/.clonehero point to games subvol

    ttyper
    nethack
    openttd
    space-cadet-pinball
    openspades
    golly

    punes mupen64plus dolphin-emu # snes9x-gtk simple64
    sameboy mgba melonDS

    r2mod_cli mons
  ];
}
