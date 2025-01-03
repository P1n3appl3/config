{ pkgs, ... }: {
  home.packages = with pkgs; [
    steam
    itch wine64
    # heroic
    lutris
    ludusavi

    prismlauncher # minecraft

    osu-lazer-bin
    clonehero # TODO: make ~/.clonehero point to games subvol

    apotris
    openttd
    space-cadet-pinball
    openspades
    hovalaag
    golly
    fence

    punes mupen64plus dolphin-emu # snes9x-gtk simple64
    sameboy mgba melonDS

    pokefinder eontimer

    slipstream # ftl mods
    r2mod_cli # risk of rain 2 mods
    everest-mons # celeste mods
  ];
}
