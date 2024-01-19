{ lib, ... }: {
  home = {
    username = "josephry"; homeDirectory = "/home/josephry";
  };
  imports = [
    ../mixins/home-manager/linux.nix
    ../mixins/home-manager/dev.nix
    ../mixins/home-manager/graphical/common.nix
    ../mixins/home-manager/graphical/i3.nix
    ../mixins/home-manager/graphical/music.nix
  ];
  xsession.initExtra = ''
  xsetroot -solid "#483157"
  export DESKTOP_SESSION="gnome"
  '';

  home.keyboard.options = [ "altwin:swap_alt_win" ];
  xdg.mimeApps.defaultApplications."text/html" = lib.mkForce "chrome.desktop";
}
