{
  home = {
    username = "josephry";
    homeDirectory = "/usr/local/google/home/josephry";
  };
  imports = [
    ../home-modules/linux.nix
    ../home-modules/btrfs.nix
    ../home-modules/dev.nix
  ];
}
