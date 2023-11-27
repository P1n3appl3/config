{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: hyprfocus or hyprdim
    # TODO: hyprgrass, or default gestures if it's analog
    hyprland
    # TODO: satty/watershot/flakeshot for annotating screenshots
    # TODO: wl-screenrec config (make sure hardware encode is working)
    wev wl-clipboard slurp grim hyprpicker # TODO: make sure screenshots work
    # TODO: try yofi/wofi/fuzzel
    # TODO: try plugins: rbw/pa source+sink/mpd/systemd/wifi
    (rofi-wayland.override { plugins = [ rofi-calc ]; })
    eww-wayland # TODO: configure, try hybridbar/ironbar
    wpaperd # TODO: configure, try swww/waypaper
    # TODO: swayosd
    swaynotificationcenter # TODO: try this/dunst/mako/fnott
    swayidle # TODO: try sleepwatcher-rs
    # TODO: swaylock/waylock/gtklock
    # TODO: polkit-kde-agen?
    # TODO: qtwayland?
    # TODO: oneko wayland port and/or https://github.com/Ibrahim2750mi/linux-goose
    # TODO: maybe use xdg-desktop-portal-hyprland for window sharing
    # TODO: check if these are already included
  ];

  services = {
    cliphist.enable = true;
  };

  # TODO: figure out if this is usable with non-nix config (warning suggests not)
  # wayland = {
  #   windowManager.hyprland.enable = true;
  # };
}

