{
  imports = [
    ./hardware.nix
    ../../mixins/nixos/headful.nix
  ];

  home-manager.users.julia.imports = [
    # { programs.kitty.settings.font_size = 15; }
    ../../mixins/home/common.nix
    ../../mixins/home/linux.nix
    ../../mixins/home/btrfs.nix
    ../../mixins/home/dev.nix
    ../../mixins/home/graphical/common.nix
    ../../mixins/home/graphical/sway.nix
    ../../mixins/home/graphical/music.nix
    ../../mixins/home/graphical/games.nix
    ../../mixins/home/graphical/media.nix
  ];

  programs = {
    steam.enable = true;
    appimage = { enable = true; binfmt = true; };
  };

  services = {
    flatpak.enable = true;
    openssh.enable = true;
  };

  networking.hostName = "HAL";
  time.timeZone = "America/Los_Angeles";
}
