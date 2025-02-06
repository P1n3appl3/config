{ pkgs, self, ... }: {
  imports = [
    ./hardware.nix
    ../../mixins/nixos/headful.nix
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
    ydotool.enable = true;
  };

  services = {
    flatpak.enable = true;
    automatic-timezoned.enable = true;
    upower.enable = true;
    udev.extraRules = ''
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="102b", MODE="0666"
    '';
  };

  networking = { hostName = "WOPR"; networkmanager.enable = true; };
}
