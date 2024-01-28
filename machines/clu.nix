{ lib, ... }: {
  home = {
    username = "josephry"; homeDirectory = "/home/josephry";
  };
  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/dev.nix
    ../mixins/home/graphical/common.nix
    ../mixins/home/graphical/i3.nix
    ../mixins/home/graphical/music.nix
  ];
  xsession.initExtra = ''
  xsetroot -solid "#483157"
  export DESKTOP_SESSION="gnome"
  '';

  home.keyboard.options = [ "altwin:swap_alt_win" ];
  xdg.mimeApps.defaultApplications."text/html" = lib.mkForce "chrome.desktop";
}
