{ pkgs, self, ... }: {
  imports = [
    ./hardware.nix
    ../../mixins/nixos/headful.nix
    ../../mixins/nixos/minecraft.nix
  ];

  home-manager.users.julia.imports = [
    {
      home.packages = with pkgs; [
        niri
        noctalia-shell
        xwayland-satellite
        mpvpaper
        wev wl-clipboard hyprpicker
        qt5.qtwayland qt6.qtwayland
        oneko
        xsnow # TODO: https://github.com/Icelk/xsnow-comp-patch
        nitrogen feh
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
        isoPath = "/media/alt/games/ROMs/Gamecube/Melee [GALE01]/game.iso";
        rootSlpPath = "/media/alt/games/melee/replays";
      };

      xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
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
      gamescopeSession.enable = true;
      protontricks.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
    };
    gamescope.enable  = true;
    appimage = { enable = true; binfmt = true; };
    nix-ld.enable = true;
    m-overlay.enable = true;
  };

  services = {
    flatpak.enable = true;
    openssh.enable = true;
    udev.packages = [
      pkgs.input-integrity
    ];
    udev.extraRules = ''
      KERNEL=="hidraw*", TAG+="uaccess"
    '';

    pipewire.jack.enable = true;

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
    firewall.allowedTCPPorts = [ 2049 27016 ]; # nft
    firewall.allowedUDPPorts = [ 27016 ]; # stationeers
  };
  time.timeZone = "America/Los_Angeles";
}
