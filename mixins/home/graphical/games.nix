{ pkgs, inputs, lib,  config, ... }: {
  home.packages = with pkgs; [
    steam
    itch wine64
    # heroic
    lutris
    ludusavi

    # melee tools
    rwing
    melee-quick-mod
    slpz

    # minecraft
    prismlauncher

    osu-lazer-bin
    yarg clonehero # TODO: make ~/.clonehero point to games subvol
    bridge

    # apotris
    openttd
    space-cadet-pinball
    # openspades TODO: cmake
    aisleriot
    golly

    # terminal
    hovalaag
    fence
    autumn
    ds-rom

    punes dolphin-emu mupen64plus # snes9x-gtk simple64
    sameboy melonDS # mgba TODO: cmake
    pcsx2

    factorio-bp-helper

    pokefinder eontimer

    slipstream # ftl mods
    r2mod_cli # risk of rain 2 mods
    olympus everest-mons # celeste mods
    nexusmods-app-unfree # bg3 mods
  ];

  # programs.fightcade = { enable = true;
  #   path = lib.mkDefault (config.home.homeDirectory + "/games/Fightcade");
  # };

  slippi-launcher = {
    useMonthlySubfolders = true;
    launchMeleeOnPlay = false;
    enableJukebox = false;
    # useNetplayBeta = true;
  };

  imports = [ inputs.slippi.homeManagerModules.default ];
}
