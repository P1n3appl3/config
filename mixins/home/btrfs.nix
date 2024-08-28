{ pkgs, ... }: {
  home.packages = with pkgs; [
    btrfs-progs
    # compsize # TODO: re-enable when fixed
    duperemove
    btdu
  ];
}
