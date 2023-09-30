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
    extraModprobeConfig = ''
      options usbcore quirks=0bda:9210:u
      options usb-storage quirks=0bda:9210:u
      '';
  };

  nixpkgs.hostPlatform = "aarch64-linux";
  powerManagement.cpuFreqGovernor = "ondemand";

  fileSystems = {
    "/boot" = { label = "boot"; fsType = "vfat"; };
    "/media" = {
      label = "pi-usb"; fsType = "ext4";
      options = [ "nofail" ];
    };
  };
}
