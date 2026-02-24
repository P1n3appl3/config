{ pkgs, self, ... }: {
  imports = [
    ./hardware.nix
    ../../mixins/nixos/cosmic.nix
    ../../mixins/nixos/headful.nix
    ../../mixins/nixos/minecraft.nix
  ];

  home-manager.users.julia.imports = [
    {
      home.packages = with pkgs; [
        oneko
        xsnow # TODO: https://github.com/Icelk/xsnow-comp-patch
        nitrogen nasa-wallpaper feh
      ];

      services = {
        cliphist.enable = true;
        udiskie.settings.device_config = [ { device_file = "/dev/sda"; ignore = true; } ];
        activitywatch.watchers.aw-watcher-windows = {
          package = pkgs.activitywatch;
          settings = { poll_time = 5; exclude_title = true; };
        };
      };

      programs.kitty.settings.font_size = 10;
      slippi-launcher = { enable = true;
        isoPath = "/media/alt/games/ROMs/Gamecube/Animelee [GALE01]/game.iso";
        rootSlpPath = "/media/alt/games/melee/replays";
      };
    }
    ../../mixins/home/common.nix
    ../../mixins/home/linux.nix
    ../../mixins/home/btrfs.nix
    ../../mixins/home/dev.nix
    ../../mixins/home/graphical/common.nix
    ../../mixins/home/graphical/music.nix
    ../../mixins/home/graphical/games.nix
    ../../mixins/home/graphical/media.nix
  ] ++ builtins.attrValues self.outputs.homeModules;

  programs = {
    steam = {
      enable = true;
      protontricks.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
    };
    appimage = { enable = true; binfmt = true; };
    nix-ld.enable = true;
    m-overlay.enable = true;
  };

  services = {
    flatpak.enable = true;
    openssh.enable = true;
    udev.packages = [
      # pkgs.xr-hardware
      # pkgs.input-integrity
    ];
    udev.extraRules = ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="102b", MODE="0666"
      KERNEL=="hidraw*", TAG+="uaccess"
    '';

    # monado = {
    #   enable = true;
    #   defaultRuntime = true;
    # };
    hardware.openrgb.enable = true;
    nfs.server = {
      enable = true;
      exports = "/home/julia/videos/torrents 192.168.1.0/24(ro,fsid=0)";
    };
  };
  # systemd.user.services.monado.environment = { STEAMVR_LH_ENABLE = "1"; XRT_COMPOSITOR_COMPUTE = "1"; };

  environment.pathsToLink = [ "/libexec" ];

  networking = {
    hostName = "HAL";
    hosts."127.0.0.1" = [ "HAL" ];
    firewall.allowedTCPPorts = [ 2049 ]; # nft
  };
  time.timeZone = "America/Los_Angeles";
}
