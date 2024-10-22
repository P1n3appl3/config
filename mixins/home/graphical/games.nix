{ pkgs, ... }: {
  home.packages = with pkgs; [
    steam
    itch wine64
    lutris
    ludusavi

    prismlauncher # minecraft

    osu-lazer-bin
    clonehero # TODO: make ~/.clonehero point to games subvol

    apotris
    openttd
    space-cadet-pinball
    openspades
    # golly

    punes mupen64plus dolphin-emu # snes9x-gtk simple64
    sameboy mgba melonDS

    slipstream # ftl mods
    r2mod_cli # risk of rain 2 mods
    everest-mons # celeste mods
  ];
}
