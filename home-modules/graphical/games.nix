{pkgs, ...}: {
  home.packages = with pkgs; [
    steam
    osu-lazer-bin # TODO: open tablet driver? try mania
    clonehero
    ludusavi # TODO: check which games aren't covered
    # TODO: desmume or other ds, gba, nes, n64, 3ds, switch
    dolphin-emu snes9x-gtk
    nethack
    openttd
    itch
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
    # - ruffle or that other one I used on windows for flash stuff
    # - https://github.com/fufexan/nix-gaming pipewire low latency for osu-lazer
    # - https://github.com/egasimus/rabbits
    # - lutris league, sc remastered/2, hearthstone, overwatch
  ];
}
