{ pkgs, ... }: {
  home = {
    homeDirectory = "/usr/local/google/home/pineapple";
    packages = with pkgs; [
      pastel
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
            criteria = "DP-2";
            position = "0,320";
            mode = "3840x2160";
            scale = 1.5;
          }
          {
            criteria = "HDMI-A-1";
            position = "3840,0";
            mode = "2560x1440";
            transform = "90";
          }
          {
            position = "5280,320";
            criteria = "eDP-1";
            status = "enable";
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
