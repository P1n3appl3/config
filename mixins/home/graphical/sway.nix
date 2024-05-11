{ pkgs, config, ... }: {
  wayland.windowManager.sway = {
   # TODO: change exec line to "systemd-cat -p sway ${pkgs.sway}/bin/sway"
    enable = true;
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
    # TODO: try ironbar/hybridbar/custom
    # TODO: swayosd
    swaynotificationcenter # TODO: try dunst/mako/fnott
    swayidle # TODO: try sleepwatcher-rs
    # TODO: swaylock/waylock/gtklock
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    wluma
    # TODO: oneko wayland port and/or https://github.com/Ibrahim2750mi/linux-goose
  ];

  programs = {
    wpaperd = { enable = true;
      settings.default = {
        path = config.xdg.userDirs.pictures + "/wallpapers";
        apply-shadow = true;
        duration = "30m";
      };
    };
    rofi.package = pkgs.rofi-wayland;
  };

  services = {
    cliphist.enable = true;
    swaync.enable = true;
  };

  systemd.user.services = {
    wpaperd = {
      Unit = {
        Description = "Wallpaper daemon";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Service = {
        Type = "simple"; Restart = "on-failure";
        ExecStart = "${pkgs.wpaperd}/bin/wpaperd -d";
      };
    };
  };
}
