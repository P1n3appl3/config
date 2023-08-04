{
  imports = [ ../../nixos-modules/btrfs.nix ];

  boot = {
    loader.grub.enable = false;
    loader.generic-extlinux-compatible.enable = true;
    initrd = {
      supportedFilesystems = [ "btrfs" ];
      availableKernelModules = [ "xhci_pci" ]; # TODO: check if "usb_storage" or "usbhid" are required
    };
  };

  nixpkgs.hostPlatform = "aarch64-linux";
  powerManagement.cpuFreqGovernor = "ondemand";

  filesystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      neededForBoot = true;
    };
    "/mnt" = {
      device = "/dev/disk/by-label/pi-usb";
      fsType = "ext4";
      # TODO: usb that doesn't block booting
    };
  };
}
