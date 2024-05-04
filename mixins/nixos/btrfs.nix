{ config, ... }: {
  fileSystems = let
    subvol = name: opts: {
      label = config.networking.hostName; fsType = "btrfs";
      options = [ "subvol=${name}" ] ++ opts;
    };
  in {
    "/"        = subvol "root" [ "compress=zstd" ];
    "/nix"     = subvol "nix"  [ "compress=zstd" "noatime" ];
    "/home"    = subvol "home" [ "compress=zstd" ];
    "/swap"    = subvol "swap" [ "noatime" ];
    "/var/log" = subvol "log"  [ ];
  };

  swapDevices = [{ device = "/swap/swapfile"; }];

  services.btrfs.autoScrub = { enable = true; fileSystems = [ "/" ]; };
}
