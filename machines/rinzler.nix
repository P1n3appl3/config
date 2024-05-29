{ pkgs, ... }: {
  home = {
    username = "pineapple";
    homeDirectory = "/usr/local/google/home/pineapple";
  };

  home.packages = with pkgs; [ git-gr ];

  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/btrfs.nix
    ../mixins/home/dev.nix
  ];
}
