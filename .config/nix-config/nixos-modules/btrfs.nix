{ config, ... }: {
  fileSystems = let
    hostname = config.networking.hostName;
  in {
    "/" = {
      label = hostname; fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };
    "/nix" = {
      label = hostname; fsType = "btrfs";
      options = [ "subvol=nix" "noatime" "compress=zstd" ];
    };
    "/home" = {
      label = hostname; fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };
    "/var/log" = {
      label = hostname; fsType = "btrfs";
      options = [ "subvol=log" "compress=zstd" ];
      neededForBoot = true;
    };
    "/persist" = {
      label = hostname; fsType = "btrfs";
      options = [ "subvol=persist" "compress=zstd" ];
      neededForBoot = true;
    };
    "/swap" = {
      label = hostname; fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };
    # TODO: use impermenance and make root ephemeral, see:
    # https://git.sr.ht/~misterio/nix-config/tree/main/item/hosts/common/optional/ephemeral-btrfs.nix
    # https://mt-caret.github.io/blog/posts/2020-06-29-optin-state.html

    # TODO: post processing to get useful output out of:
    # sudo btrfs send --no-data -p /blank / | btrfs receive --dump
    # maybe create a snapshot right after boot and then diff it upon shutdown,
    # possibly saving a snapshot with whatever new files exist before they get
    # wiped on the next reboot. btrfs subvolume find-new might be the thing
  };
  swapDevices = [{ device = "/swap/swapfile"; }];
}
