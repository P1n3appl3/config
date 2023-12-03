{ config, lib, ... }: {
  imports = [ ../../nixos-modules/btrfs.nix ];

  # fileSystems = let
  #   subvol = name: opts: {
  #     label = config.networking.hostName; fsType = "btrfs";
  #     options = [ "subvol=${name}" ] ++ opts;
  #   };
  # in {
  #   # ".cache" = subvol "cache" [ "compress=zstd" ];
  #   # ".cargo" = subvol "cargo" [ "compress=zstd" "noatime" ];
  #   # "dev" = subvol "dev" [ "compress=zstd" ];
  #   # "games" = subvol "games" [ "compress=zstd" ];
  #   # ".local/share/Steam" = subvol "swap" [ "compress=zstd" ]; # TODO: should this be ".steam"
  # };

  networking.networkmanager.enable = true;

  services.fwupd.enable = true;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
