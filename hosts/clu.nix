{ pkgs, ... }: {
  home = {
    username = "josephry"; homeDirectory = "/home/josephry";
  };
  home.packages = with pkgs; [ powertop ];
  imports = [
    ../home-modules/linux.nix
    ../home-modules/dev.nix
    ../home-modules/graphical/i3.nix
    ../home-modules/graphical/music.nix
  ];
  xsession.initExtra = ''
  xsetroot -solid "#483157"
  export DESKTOP_SESSION="gnome"
  '';
}
