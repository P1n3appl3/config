{
  home = {
    username = "josephry";
    homeDirectory = "/usr/local/google/home/josephry";
  };
  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/btrfs.nix
    ../mixins/home/dev.nix
  ];
}
