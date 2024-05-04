{ pkgs, ... }: {
  home = {
    username = "josephry";
    homeDirectory = "/usr/local/google/home/josephry";
  };

  home.packages = with pkgs; [ git-gr ];

  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/btrfs.nix
    ../mixins/home/dev.nix
  ];
}
