{ lib, pkgs, ... }: {
  home = {
    username = "josephry"; homeDirectory = "/home/josephry";
  };
  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/dev.nix
    ../mixins/home/graphical/common.nix
    ../mixins/home/graphical/sway.nix
    ../mixins/home/graphical/music.nix
  ];

  home.packages = with pkgs; [ pastel ];
  home.keyboard.options = [ "altwin:swap_alt_win" ];
  xdg.mimeApps.defaultApplications =
    let chrome = lib.mkForce "chrome.desktop"; in {
    "text/html" = chrome;
    "x-scheme-handler/http" = chrome;
    "x-scheme-handler/https" = chrome;
  };
}
