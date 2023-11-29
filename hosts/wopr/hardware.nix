{
  imports = [ ../../nixos-modules/btrfs.nix ];
  services.fwupd.enable = true;
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
}
