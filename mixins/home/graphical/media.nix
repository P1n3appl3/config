{ pkgs, ... }: {
  home.packages = with pkgs; [
    kdePackages.kdenlive
    yt-dlp
    godot_4
    blender
    # TODO: graphite
    inkscape krita pinta aseprite
    gthumb
    helio-workstation
    musescore transcribe
    # deflemask furnace
    # non lmms ardour
    audacity # (or tenacity)
    logisim-evolution # circuit-artist

    kicad-small
    calibre

    # TODO: transcribe lotus:
    # pkgs-stable.easyabc abctool

    sweethome3d.application
  ];

  programs = {
    obs-studio = { enable = true;
      package = (pkgs.obs-studio.override { cudaSupport = true; });
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        obs-livesplit-one # TODO: see if it works and i can delete mine
        obs-gamepad
      ];
    };
  };
}
