{ pkgs, lib, ... }: {
  imports = [
    ./hardware.nix
    ./web.nix
    ../../mixins/nixos/headful.nix
    ../../mixins/nixos/backups.nix
  ];

  home-manager.users.julia.imports = [
    ../../mixins/home/common.nix
    ../../mixins/home/linux.nix
    ../../mixins/home/btrfs.nix
  ];

  environment = {
    enableAllTerminfo = true;
  };

  time.timeZone = "America/Los_Angeles";
  networking.hostName = "Cortana";
}
