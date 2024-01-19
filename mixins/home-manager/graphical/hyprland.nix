{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: try hyprfocus and hyprdim
    wev wl-clipboard slurp grim hyprpicker # TODO: make sure screenshots work
    # TODO: wl-screenrec config (make sure hardware encode is working)
    # TODO: try satty or watershot
    # TODO: try yofi/wofi/fuzzel
    # TODO: try plugins: rbw/pa source+sink/mpd/systemd/wifi
    (rofi-wayland.override { plugins = [ rofi-calc ]; })
    ironbar # TODO: configure, try hybridbar/custom
    wpaperd swww # TODO: choose
    # TODO: swayosd
    swaynotificationcenter # TODO: try this/dunst/mako/fnott
    swayidle # TODO: try sleepwatcher-rs
    # TODO: swaylock/waylock/gtklock
    # TODO: polkit-kde-agen?
    # TODO: qtwayland?
    # TODO: oneko wayland port and/or https://github.com/Ibrahim2750mi/linux-goose
    # TODO: check if these are already included
    i3status-rust # TODO: remove once eww working
  ];

  services = {
    cliphist.enable = true;
  };

  # need to start graphical-session and tray targets beccause other hm modules depend on them
  systemd.user.targets = {
    hyprland-session.Unit = {
      Description = "Hyprland compositor session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
    tray.Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1"; # TODO: see if GTK_USE_PORTAL is needed
}

