{
  imports = [ ../../nixos-modules/btrfs.nix ];

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    initrd = {
      supportedFilesystems = [ "btrfs" ];
      availableKernelModules = [ "xhci_pci" "usb_storage" "usbhid" ];
    };
  };

  nixpkgs.hostPlatform = "aarch64-linux";
  powerManagement.cpuFreqGovernor = "ondemand";

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      neededForBoot = true;
    };
    "/mnt" = {
      device = "/dev/disk/by-label/pi-usb";
      fsType = "ext4";
      options = [ "nofail" ];
    };
  };
}
