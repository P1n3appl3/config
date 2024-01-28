{
  home = {
    username = "deck"; homeDirectory = "/home/deck";
  };
  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/btrfs.nix
  ];
}
