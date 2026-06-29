{ pkgs, ... }: {
  home.packages = with pkgs; [
    blender
    kdePackages.kdenlive
    kicad-small
    inkscape krita pinta aseprite
    audacity # (or tenacity)
    logisim-evolution circuit-artist
    godot_4
    freecad
    # TODO: graphite
    yt-dlp
    gthumb
    calibre

    musescore transcribe helio-workstation
    furnace # deflemask
    # ardour non lmms
    reaper reaper-sws-extension reaper-reapack-extension
    guitarix jalv carla tonelib-gfx
    neural-amp-modeler-lv2

    # TODO: transcribe lotus:
    # pkgs-stable.easyabc abctool

    # sweethome3d.application
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
