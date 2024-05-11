{ pkgs, ... }: {
  home.packages = with pkgs; [
    obs-studio kdenlive blender godot_4
    non lmms ardour audacity # (or tenacity)
    inkscape krita pinta
    (calibre.override { speechd=null; })
    aseprite
  ];
}
