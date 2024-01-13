{ lib, ... }: {
  home = {
    username = "josephry"; homeDirectory = "/home/josephry";
  };
  imports = [
    ../home-modules/linux.nix
    ../home-modules/dev.nix
    ../home-modules/graphical/common.nix
    ../home-modules/graphical/i3.nix
    ../home-modules/graphical/music.nix
  ];
  xsession.initExtra = ''
  xsetroot -solid "#483157"
  export DESKTOP_SESSION="gnome"
  '';

  home.keyboard.options = [ "altwin:swap_alt_win" ];
  xdg.mimeApps.defaultApplications."text/html" = lib.mkForce "chrome.desktop";
}
