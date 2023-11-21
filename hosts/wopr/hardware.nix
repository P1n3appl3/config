{
  imports = [ ../../nixos-modules/btrfs.nix ];
  services.fwupd.enable = true;
  boot.loader.systemd-boot.enable = true;
  # TODO: do i want powerManagement.powerTop.enable = true; (autotune every boot)
}
