{ pkgs, ... }: {
  home.packages = with pkgs; [
    brightnessctl
  ];

  services = {
    network-manager-applet.enable = true; # TODO: greyed out available networks?
  };
}
