{ pkgs, lib, ... }: {
  imports = [
    ./hardware.nix
    ./web.nix
    ../../mixins/nixos/headful.nix
    ../../mixins/nixos/backups.nix
  ];

  home-manager.users.julia.imports = [
    ../../mixins/home/common.nix
    ../../mixins/home/linux.nix
    ../../mixins/home/btrfs.nix
    ../../mixins/home/dev.nix
    ../../mixins/home/graphical/terminal.nix
    # check if this is necessary when using plasma
    { services.kdeconnect = { enable = true; indicator = true; }; }
    # try plasma defaults before using these
    # ../../mixins/home/graphical/theme.nix
    # ../../mixins/home/graphical/fonts.nix
  ];

  services.desktopManager.plasma6.enable = true;
  
  environment = {
    enableAllTerminfo = true;
    systemPackages = with pkgs; [
      kdePackages.plasma-bigscreen
      (mpv.override { scripts = with mpvScripts; [ mpris uosc thumbfast ]; })
      ffmpeg imv qbittorrent qbittorrent-cli
    ];
  };

  time.timeZone = "America/Los_Angeles";
  networking.hostName = "Cortana";
}
