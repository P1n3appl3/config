{ pkgs, pkgs-stable, ... }: {
  home.packages = with pkgs; [
    kdenlive
    yt-dlp
    godot_4
    blender
    # TODO: graphite
    inkscape krita pinta oculante aseprite
    helio-workstation
    furnace
    # non lmms ardour
    audacity # (or tenacity)
    logisim-evolution

    # TODO: re-enable when fixed
    # kicad-small
    # calibre

    # TODO: transcribe lotus:
    # pkgs-stable.easyabc abctool
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
