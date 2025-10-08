{ pkgs, pkgs-stable, ... }: {
  home.packages = with pkgs; [
    kdePackages.kdenlive
    yt-dlp
    godot_4
    blender
    # TODO: graphite
    inkscape krita pinta # aseprite TODO: cmake
    gthumb
    helio-workstation
    musescore
    # deflemask furnace
    # non lmms ardour
    audacity # (or tenacity)
    logisim-evolution

    kicad-small
    # calibre TODO: cmake

    # TODO: transcribe lotus:
    # pkgs-stable.easyabc abctool

    sweethome3d.application
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
