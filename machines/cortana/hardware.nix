{ inputs, ...}: {
  imports = [
    ../../mixins/nixos/btrfs.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
    initrd = {
      supportedFilesystems.btrfs = true;
      availableKernelModules = [ "xhci_pci" "usb_storage" "usbhid" ];
    };
    extraModprobeConfig = ''
      options usbcore quirks=0bda:9210:u
      options usb-storage quirks=0bda:9210:u
      '';

    # https://artemis.sh/2023/06/06/cross-compile-nixos-for-great-good.html
    binfmt.emulatedSystems = [ "x86_64-linux" ];
    kernelParams = [ "psi=1" ];
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
