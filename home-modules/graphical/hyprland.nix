{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: yofi/wofi/fuzzel + plugins
    eww-wayland # TODO: configure
    wl-clipboard slurp grim hyprpicker # TODO: make sure screenshots work
    swaynotificationcenter # TODO: try this/dunst/mako/fnott
    wpaperd # TODO: configure, try swww/waypaper
    # TODO: swaylock/waylock/gtklock
    # TODO: polkit-kde-agen?
    # TODO: qtwayland?
    # TODO: oneko wayland port and/or https://github.com/Ibrahim2750mi/linux-goose
  ];

  services = {
    cliphist.enable = true;
  };

  wayland = {
    windowManager.hyprland.enable = true;
  };
}

