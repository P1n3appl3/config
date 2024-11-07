{ pkgs, ... }: {
  home = {
    homeDirectory = "/usr/local/google/home/pineapple";
    packages = with pkgs; [
      pastel
      power-profiles-daemon
    ];
  };

  programs.wpaperd.settings = {
    HDMI-A-1.path = "~/images/waneella/portrait";
  };

  services.kanshi = { enable = true;
    settings = [
      {
        profile.name = "undocked"; profile.outputs = [
          { criteria = "eDP-1"; mode = "3840x2160"; scale = 2.0; }
        ];
      }
      {
        profile.name = "docked"; profile.outputs = [
          {
            criteria = "DP-1";
            position = "0,0";
            mode = "3840x2160";
            scale = 1.5;
          }
          {
            position = "3840,0";
            criteria = "eDP-1";
            status = "enable";
            scale = 2.0;
          }
        ];
      }
    ];
  };

  dev.compilers = false;

  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/dev.nix
    ../mixins/home/work.nix
    ../mixins/home/graphical/common.nix
    ../mixins/home/graphical/sway.nix
    ../mixins/home/graphical/music.nix
  ];
}
