{ pkgs, ... }: {
  home = {
    username = "deck"; homeDirectory = "/home/deck";
  };
  imports = [
    ../home-modules/linux.nix
    ../home-modules/btrfs.nix
  ];
}
