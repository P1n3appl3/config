{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    ../../mixins/nixos/headful.nix
  ];

  home-manager.users.julia.imports = [
    { programs.kitty.settings.font_size = 15; }
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

  environment.systemPackages = with pkgs; [
    littlefs-fuse
  ];

  programs = {
    steam.enable = true;
    appimage = { enable = true; binfmt = true; };
  };

  services = {
    flatpak.enable = true;
    automatic-timezoned.enable = true;
    upower.enable = true;
  };

  networking = { hostName = "WOPR"; networkmanager.enable = true; };
}
