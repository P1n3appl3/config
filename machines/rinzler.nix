{ lib, pkgs, ... }: {
  home.homeDirectory = lib.mkForce "/usr/local/google/home/pineapple";

  home.packages = with pkgs; [
    git-gr
    gn
  ];

  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/btrfs.nix
    ../mixins/home/dev.nix
    ../mixins/home/work.nix
    ../mixins/home/graphical/common.nix
    ../mixins/home/graphical/sway.nix
  ];
}
