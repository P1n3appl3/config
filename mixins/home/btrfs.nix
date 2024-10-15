{ pkgs, ... }: {
  home.packages = with pkgs; [
    btrfs-progs
    compsize
    duperemove
    btdu
  ];
}
