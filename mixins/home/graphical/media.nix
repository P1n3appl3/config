{ pkgs, ... }: {
  home.packages = with pkgs; [
    kdenlive
    yt-dlp
    godot_4
    blender
    inkscape krita pinta oculante aseprite
    furnace lmms ardour audacity # (or tenacity)
    non
    logisim-evolution
    kicad-small
    # calibre # TODO: re-enable when fixed
  ];

  programs = {
    obs-studio = { enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-livesplit-one # TODO: see if it works and i can delete mine
        obs-gamepad
      ];
    };
  };
}
