{ pkgs, inputs, ... }: {
  imports = [
    ./hardware.nix
    ../../mixins/nixos/headful.nix
  ];

  home-manager.users.julia.imports = [
    (let iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; }; in {
      home.packages = with pkgs; [
        i3
        xclip maim xcolor
        (rofi.override { plugins = [ rofi-calc ]; })
        dunst
        oneko
        xorg.xeyes xorg.xkill
        xsnow # TODO: https://github.com/Icelk/xsnow-comp-patch
      ];

      systemd.user.services.clipmenu.Service.Environment = ["CM_SELECTIONS=clipboard"];
      services = {
        clipmenu.enable = true;
        dunst = { enable = true;
          inherit iconTheme;
          settings = {
            global = {
              monitor = 1;
              frame_color = "#788388";
              frame_width = 0;
              corner_radius = 8;
              width = "(0, 500)";

              font = "sans 12";
              markup = "full";
              max_icon_size = 32;
              icon_position = "left";
              format = ''%s %p\n%b'';
              show_age_threshold = 60;
              dmenu = "rofi -dmenu -p dunst";
            };
            urgency_low = { background = "#263238"; foreground = "#556064"; };
            urgency_normal = { background = "#263238"; foreground = "#F9FAF9"; };
            urgency_critical = { background = "#D62929"; foreground = "#F9FAF9"; };
          };
        };
      };

      xsession = { enable = true; windowManager.command = "i3"; };
      programs.kitty.settings.font_size = 10;
      slippi.launcher = { enable = true;
        isoPath = "/media/alt/games/ROMs/Gamecube/Animelee [GALE01]/game.iso";
        rootSlpPath = "/media/alt/games/melee/replays";
        useMonthlySubfolders = true;
        launchMeleeOnPlay = false;
      };
      # xsession.windowManager.i3 = {
      #   enable = true;
      #   package = pkgs.i3-gaps;
      #   enableDefault = false;
      #   extraConfigEarly = "include ~/.config/i3/common_config";
      # };
    })
    ../../mixins/home/common.nix
    ../../mixins/home/linux.nix
    ../../mixins/home/btrfs.nix
    ../../mixins/home/dev.nix
    ../../mixins/home/graphical/common.nix
    ../../mixins/home/graphical/music.nix
    ../../mixins/home/graphical/games.nix
    ../../mixins/home/graphical/media.nix
    inputs.slippi.homeManagerModules.default
  ];

  programs = {
    steam.enable = true;
    appimage = { enable = true; binfmt = true; };
  };

  services = {
    xserver = { enable = true;
      windowManager.i3.enable = true;
      screenSection = ''
        Option "metamodes" "DP-4: 1920x1080_144 +2560+0 {rotation=left}, DP-2: 2560x1440_144 +0+480"
      '';
    };
    displayManager.defaultSession = "none+i3";
    flatpak.enable = true;
    openssh.enable = true;
    udev.extraRules = ''
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="102b", MODE="0666"
    '';
  };

  environment.pathsToLink = [ "/libexec" ];

  networking.hostName = "HAL";
  time.timeZone = "America/Los_Angeles";
}
