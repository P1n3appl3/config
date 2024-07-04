{ pkgs, ... }: {
  home.packages = with pkgs; [
    steam
    lutris # use this for itch
    ludusavi

    osu-lazer-bin
    clonehero # TODO: make ~/.clonehero point to games subvol

    openttd
    space-cadet-pinball
    openspades
    golly

    punes mupen64plus dolphin-emu # snes9x-gtk simple64
    sameboy mgba melonDS

    slipstream # ftl mods
    r2mod_cli # risk of rain 2 mods
    mons # celeste mods
  ];
}
