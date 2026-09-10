{ inputs, ...}: {
  imports = [
    ../../mixins/nixos/btrfs.nix
  ];

  boot = {
    loader = {
      systemd-boot = { enable = true;
        configurationLimit = 5;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true;
    amdgpu = {
      overdrive.enable = true;
      initrd.enable = true;
    };
    opentabletdriver = {
      enable = true;
      blacklistedKernelModules = [ "wacom" ];
    };
  };

  fileSystems = {
    "/boot" = { label = "boot"; fsType = "vfat"; };
    "/media" = {
      label = "pi-usb"; fsType = "ext4";
      options = [ "nofail" ];
    };
  };
}
