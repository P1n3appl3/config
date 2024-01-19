{
  home = {
    username = "josephry";
    homeDirectory = "/usr/local/google/home/josephry";
  };
  imports = [
    ../mixins/home-manager/linux.nix
    ../mixins/home-manager/btrfs.nix
    ../mixins/home-manager/dev.nix
  ];
}
