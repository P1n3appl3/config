{ config, pkgs, lib, self, ... }: {
  imports = [
    ./hardware.nix
    ../../mixins/nixos/headful.nix
    ../../mixins/nixos/backups.nix
    ../../mixins/nixos/minecraft.nix
  ];

  home-manager.users.julia.imports = [
    {
      home.packages = with pkgs; [
        noctalia-shell
        xwayland-satellite
        mpvpaper
        wev wl-clipboard hyprpicker
        qt5.qtwayland qt6.qtwayland
        oneko
        xsnow # TODO: https://github.com/Icelk/xsnow-comp-patch
        amdgpu_top
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
    niri.enable = true;
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
    lact.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
    pipewire.jack.enable = true;
    udev.packages = [
      pkgs.input-integrity
    ];
    udev.extraRules = ''
      KERNEL=="hidraw*", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="17cb", TAG+="uaccess", RUN+="/bin/sh -c 'echo -n %k > /sys/bus/usb/drivers/btusb/unbind'"
    ''; # bt adapter for wiimotes in dolphin

    hardware.openrgb.enable = true;
    nfs.server = {
      enable = true;
      exports = "/home/julia/videos/torrents 192.168.1.0/24(ro,fsid=0)";
    };
    porkbun-ddns = { enable = true;
      secret-key = config.age.secrets.porkbun-secret.path;
      api-key = config.age.secrets.porkbun-api.path;
      ipv6 = true;
      ipv4 = false;
      domains = [ "hal.pineapple.computer" ];
    };
  };
  
  age.secrets = {
    porkbun-api.file = ../../secrets/porkbun-api.age;
    porkbun-secret.file = ../../secrets/porkbun-secret.age;
  };

  xdg.portal = {
    wlr.enable = false;
    config = {
      common.default = [ "gnome" "gtk" ];
        niri = {
          default = [ "gnome" "gtk" ];
          "org.freedesktop.impl.portal.Screencast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
      };
    };
  };

  networking = {
    hostName = "HAL";
    hosts."127.0.0.1" = [ "HAL" ];
    firewall.allowedTCPPorts = [
      2049 # nft
      27016 # stationeers
    ];
    firewall.allowedUDPPorts = [
      27016 # stationeers
      34196 34197 # factorio
      20582 # slippi discovery
    ];
  };
  time.timeZone = "America/Los_Angeles";
  environment.pathsToLink = [ "/libexec" ];
}
