{
  home = {
    username = "deck"; homeDirectory = "/home/deck";
  };
  imports = [
    ../mixins/home-manager/linux.nix
    ../mixins/home-manager/btrfs.nix
  ];
}
