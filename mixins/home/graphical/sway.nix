{ pkgs, lib, config, ... }: {
  wayland.windowManager.sway = { enable = true;
   # TODO: change exec line to "systemd-cat -p sway ${pkgs.sway}/bin/sway"
   # TODO: wrapper features?
    catppuccin.enable = true;
    systemd.xdgAutostart = true;
    extraSessionCommands = ''
      export NIXOS_OZONE_WL="1";
    '';
    extraConfigEarly = "include ~/.config/sway/common_config";
    config = null;
  };

  home.packages = with pkgs; [
    wev wl-clipboard slurp grim hyprpicker wlprop
    # TODO: wl-screenrec config (make sure hardware encode is working)
    # TODO: try satty or watershot
    swaynotificationcenter # TODO: try dunst/mako/fnott
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    wluma
    # TODO: oneko wayland port and/or https://github.com/Ibrahim2750mi/linux-goose
    wpaperd # TODO: add to home-manager service so wpaperctl is in PATH
  ];

  programs = {
    rofi.package = pkgs.rofi-wayland;
    wpaperd = { enable = true;
      settings.default = {
        path = config.xdg.userDirs.pictures + "/wallpapers";
        apply-shadow = true;
        duration = "30m";
      };
    };
    swaylock = { enable = true; # TODO: try gtklock
      catppuccin.enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        daemonize = true; screenshot = true; clock = true; indicator = true;
        ignore-empty-password = true; show-failed-attempts = true;
        inside-color = lib.mkForce "1e1e2eaa"; effect-blur = "7x5";
      };
    };
  };

  services = {
    swayidle = { enable = true;
      events = [
        { event = "before-sleep"; command = "playerctl pause"; }
        { event = "before-sleep"; command = "swaylock"; }
        { event = "lock"; command = "swaylock"; }
      ];
      timeouts = let screen = state: "swaymsg 'output * dpms ${state}'"; in [
        { timeout = 120; command = screen "off"; resumeCommand = screen "on"; }
      ];
    };
    cliphist.enable = true;
    swaync.enable = true; # TODO: ctp
    swayosd.enable = true; # TODO: ctp
  };

  systemd.user.services = {
    wpaperd = {
      Unit = {
        Description = "Wallpaper daemon";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Service = {
        Restart = "on-failure";
        ExecStart = "${pkgs.wpaperd}/bin/wpaperd -d";
      };
    };
  };
}
