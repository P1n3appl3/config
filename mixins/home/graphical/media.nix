{ pkgs, ... }: {
  home.packages = with pkgs; [
    obs-studio kdenlive
    godot_4
    blender
    inkscape krita pinta aseprite
    furnace non lmms ardour audacity # (or tenacity)
    logisim-evolution kicad-small
    calibre
  ];
}
