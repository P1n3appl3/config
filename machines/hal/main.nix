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
        vscode
      ];

      systemd.user.services.clipmenu.Service.Environment = ["CM_SELECTIONS=clipboard"];
      services = {
        clipmenu.enable = true;
        udiskie.settings.device_config = [ { device_file = "/dev/sda"; ignore = true; } ];
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
      slippi-launcher = { enable = true;
        isoPath = "/media/alt/games/ROMs/Gamecube/Animelee [GALE01]/game.iso";
        rootSlpPath = "/media/alt/games/melee/replays";
        useMonthlySubfolders = true;
        launchMeleeOnPlay = false;
        enableJukebox = false;
      };
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
    nix-ld.enable = true;
    m-overlay.enable = true;
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
    # udev.packages = [ pkgs.input-integrity ];
  };

  users.users.julia.extraGroups = [ "dialout" ];

  environment.pathsToLink = [ "/libexec" ];

  networking.hostName = "HAL";
  time.timeZone = "America/Los_Angeles";
}
