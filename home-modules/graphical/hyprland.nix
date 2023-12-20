{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: hyprfocus or hyprdim
    # TODO: hyprgrass, or default gestures if it's analog
    # TODO: satty/watershot/flakeshot for annotating screenshots
    # TODO: wl-screenrec config (make sure hardware encode is working)
    wev wl-clipboard slurp grim hyprpicker # TODO: make sure screenshots work
    # TODO: try yofi/wofi/fuzzel
    # TODO: try plugins: rbw/pa source+sink/mpd/systemd/wifi
    (rofi-wayland.override { plugins = [ rofi-calc ]; })
    ironbar eww-wayland # TODO: configure, try hybridbar/custom
    wpaperd # TODO: configure, try swww/waypaper
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

  # start graphical-session and tray targets beccause other hm modules depend on them
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
}

