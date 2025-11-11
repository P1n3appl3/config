{ pkgs, inputs, ... }: {
  imports = [
    ../../mixins/nixos/btrfs.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  environment.systemPackages = with pkgs; [
    nvtopPackages.amd amdgpu_top
  ];

  services = {
    fprintd.tod = { enable = true; driver = pkgs.libfprint-2-tod1-goodix; };
    fwupd.enable = true;
    logind = {
      settings.Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandlePowerKey = "hibernate";
        IdleAction = "suspend-then-hibernate";
        IdleActionSec = "10m";
      };
    };
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=4h";

  boot = {
    loader = {
      systemd-boot = { enable = true;
        configurationLimit = 10;
        memtest86.enable = true;
        consoleMode = "1";
      };
      efi.canTouchEfiVariables = true;
    };
    # offset from btrfs inspect-internal map-swapfile -r /swap/swapfile
    kernelParams = [ "mem_sleep_default=deep" "resume_offset=533760" ];
    resumeDevice = "/dev/disk/by-label/WOPR";
  };

  hardware = {
    bluetooth = { enable = true; powerOnBoot = false; };
    enableRedistributableFirmware = true; # enables microcode updates
  };
  networking.usePredictableInterfaceNames = false; # I like wlan0

  fileSystems = {
    "/boot" = { label = "boot"; fsType = "vfat"; };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
