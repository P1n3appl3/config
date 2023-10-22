{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    osu-lazer-bin # TODO: open tablet driver?
    clonehero
    ludusavi # TODO: check which games aren't covered
    snes9x-gtk
    dolphin-emu
    nethack
    # TODO: lots
    # - eggnogg / +
    # - slippi + kernel module + skins? https://github.com/djanatyn/ssbm-nix
    # - https://github.com/rrbutani/HSDLib and xdelta for modding
    # - everest for celeste, r2modman for ror2, the ftl mod manager, etc.
    # - use flatpak for fightcade
    # - battle.net for starcraft: https://nixos.wiki/wiki/Battle.net
    # - minecraft + mods, maybe https://github.com/Infinidoge/nix-minecraft
    # - looking glass hooked up to dual boot partition
    #   might need https://github.com/danielfullmer/nixos-nvidia-vgpu
    #   and or https://github.com/DualCoder/vgpu_unlock
    # - sabaki sgf viewer
    # - shattered-pixel-dungeon or maybe just steam version
  ];
}
