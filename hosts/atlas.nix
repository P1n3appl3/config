{ pkgs, ... }: {
  home = {
    username = "deck"; homeDirectory = "/home/deck";
  };
  home.packages = with pkgs; [ powertop ];
  imports = [
    ../home-modules/linux.nix
    ../home-modules/btrfs.nix
  ];
}
