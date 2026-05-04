{ pkgs, lib, self, ... }: {
  imports = [
    ./hardware.nix
    ../../mixins/nixos/headful.nix
    # ../../mixins/nixos/cosmic.nix
  ];

  home-manager.users.julia.imports = [
    {
      programs.kitty.settings.font_size = 15;
      gtk.font.size = 15;
      programs.waybar.style = ''
        * {
            font-size: 22px;
        }
      '';
      wayland.windowManager.sway.extraSessionCommands = ''
        export QT_SCALE_FACTOR=1.5
      '';
      slippi-launcher = { # enable = true;
        isoPath = "/home/julia/games/roms/Gamecube/Melee [GALE01]/game.iso";
        rootSlpPath = "/home/julia/games/melee/replays";
      };
    }
    ../../mixins/home/common.nix
    ../../mixins/home/linux.nix
    ../../mixins/home/btrfs.nix
    ../../mixins/home/dev.nix
    ../../mixins/home/graphical/common.nix
    ../../mixins/home/graphical/sway.nix
    ../../mixins/home/graphical/music.nix
    ../../mixins/home/graphical/games.nix
    ../../mixins/home/graphical/media.nix
  ] ++ builtins.attrValues self.outputs.homeModules;

  environment.systemPackages = with pkgs; [
    littlefs-fuse
  ];

  programs = {
    steam.enable = true;
    appimage = { enable = true; binfmt = true; };
    nix-ld.enable = true;
    ydotool.enable = true;
  };

  services = {
    openssh.enable = true;
    flatpak.enable = true;
    automatic-timezoned.enable = true;
    upower.enable = true;
    # TODO: try dual-function-keys for more options
    interception-tools = let
       tools = pkgs.interception-tools;
       caps2esc = lib.getExe pkgs.interception-tools-plugins.caps2esc;
    in { enable = true;
      udevmonConfig = ''
        - JOB: "${tools}/bin/intercept -g $DEVNODE | ${caps2esc} | ${tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };
    udev.packages = [
      pkgs.input-integrity
    ];
  };

  networking = { hostName = "WOPR"; networkmanager.enable = true; };
}
