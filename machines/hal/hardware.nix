{ pkgs, ... }: {
  imports = [ ../../mixins/nixos/btrfs.nix ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];

  boot = {
    loader = {
      systemd-boot = { enable = true;
        configurationLimit = 5;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    # offset from btrfs inspect-internal map-swapfile -r /swap/swapfile
    kernelParams = [ "mem_sleep_default=deep" "resume_offset=533760" ];
    resumeDevice = "/dev/disk/by-label/HAL";
    initrd.availableKernelModules = [
      "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"
    ];
  };

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    nvidia.open = false;
    opentabletdriver = {
      enable = true;
      blacklistedKernelModules = [ "wacom" ];
    };
  };

  networking = {
    usePredictableInterfaceNames = false; # I like eth0
    # useDHCP = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  fileSystems = {
    "/boot" = { label = "boot"; fsType = "vfat"; };
    "/media/alt" = { label = "alt"; fsType = "btrfs"; options = [ "compress=zstd" ]; };
    "/media/windows" = { label = "windows"; fsType = "ntfs-3g"; };
    "/media/windata" = { label = "windata"; fsType = "ntfs-3g"; };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
