{ pkgs, ... }: {
  home.packages = with pkgs; [
    kdenlive
    godot_4
    blender
    inkscape krita pinta aseprite
    furnace lmms ardour audacity # (or tenacity)
    non
    logisim-evolution
    kicad-small
    calibre
  ];

  programs = {
    obs-studio = { enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-livesplit-one # TODO: see if it works and i can delete mine
      ];
    };
  };
}
