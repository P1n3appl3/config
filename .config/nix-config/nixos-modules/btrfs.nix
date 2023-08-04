{ config, ... }: {
  fileSystems = let
    hostname = config.networking.hostName;
  in {
    "/" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };
    "/nix" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };
    "/home" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };
    "/swap" = {
      device = "/dev/disk/by-label/${hostname}";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };
    # TODO: make root ephemeral, see:
    # https://git.sr.ht/~misterio/nix-config/tree/main/item/hosts/common/optional/ephemeral-btrfs.nix
    # https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html
  };
  swapDevices = [{ device = "/swap/swapfile"; }];
}
