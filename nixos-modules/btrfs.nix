{ config, ... }: {
  fileSystems = let
    hostname = config.networking.hostName;
    subvol = name: opts: {
      label = hostname; fsType = "btrfs"; options = [ "subvol=${name}" ] ++ opts;
    };
  in {
    "/" = subvol "root" [ "compress=zstd" ];
    "/nix" = subvol "nix" [ "compress=zstd" "noatime" ];
    "/home" = subvol "home" [ "compress=zstd" ];
    "/var/log" = subvol "log" [ "compress=zstd" ];
    "/swap" = subvol "swap" [ "noatime" ];
    "/persist" = (subvol "persist" [ "compress=zstd" ]) // {
      neededForBoot = true;
    };
  };

  swapDevices = [{ device = "/swap/swapfile"; }];
}
