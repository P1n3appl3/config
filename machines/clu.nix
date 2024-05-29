{ lib, pkgs, ... }: {
  home = {
    username = "pineapple"; homeDirectory = "/home/pineapple";
  };
  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/dev.nix
    ../mixins/home/graphical/common.nix
    ../mixins/home/graphical/sway.nix
    ../mixins/home/graphical/music.nix
  ];

  home.packages = with pkgs; [
    pastel
  ];

  programs.kitty.settings.font_size = 14;

  services.syncthing.enable = lib.mkForce false;
  services.syncthing.tray.enable = lib.mkForce false;

  xdg.mimeApps.defaultApplications =
    let chrome = lib.mkForce "chrome.desktop"; in {
    "text/html" = chrome;
    "x-scheme-handler/http" = chrome;
    "x-scheme-handler/https" = chrome;
  };
}
