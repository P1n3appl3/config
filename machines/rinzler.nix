{ lib, pkgs, ... }: {
  home = {
    username = "pineapple";
    homeDirectory = "/usr/local/google/home/pineapple";
  };

  home.packages = with pkgs; [
    git-gr
    gn
  ];

  services.syncthing.enable = lib.mkForce false;
  services.syncthing.tray.enable = lib.mkForce false;

  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/btrfs.nix
    ../mixins/home/dev.nix
    ../mixins/home/graphical/common.nix
    ../mixins/home/graphical/sway.nix
  ];

  xdg.mimeApps.defaultApplications =
    let chrome = lib.mkForce "chrome.desktop"; in {
    "text/html" = chrome;
    "x-scheme-handler/http" = chrome;
    "x-scheme-handler/https" = chrome;
  };
}
