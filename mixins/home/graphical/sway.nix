{pkgs, config, ...}: {
  wayland.windowManager.sway = {
   # TODO: change exec line to "systemd-cat -p sway ${pkgs.sway}/bin/sway"
    enable = true;
    systemd.xdgAutostart = true;
    # TODO: see if GTK_USE_PORTAL is needed
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
    # TODO: try yofi/wofi/fuzzel
    # TODO: try plugins: rbw/pa source+sink/mpd/systemd/wifi
    (rofi-wayland.override { plugins = [ rofi-calc ]; })
    i3status-rust ironbar # TODO: configure, try hybridbar/custom
    # TODO: swayosd
    swaynotificationcenter # TODO: try this/dunst/mako/fnott
    swayidle # TODO: try sleepwatcher-rs
    # TODO: swaylock/waylock/gtklock
    # TODO: qtwayland?
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
  };

  services = {
    cliphist.enable = true;
  };
}

