{
  imports = [ ../../nixos-modules/btrfs.nix ];

  services.fwupd.enable = true;

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  networking.usePredictableInterfaceNames = false; # i like wlan0

  fileSystems = {
    "/boot" = { label = "boot"; fsType = "vfat"; };
  };
}
