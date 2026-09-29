{pkgs, ...}: {
  imports = [ ../../mixins/nixos/btrfs.nix ];

  boot = {
    # offset from btrfs inspect-internal map-swapfile -r /swap/swapfile
    kernelParams = [ "mem_sleep_default=deep" "resume_offset=92180856" ];
    resumeDevice = "/dev/disk/by-label/HAL";
    initrd.availableKernelModules = [
      "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"
    ];
  };

  hardware = {
    bluetooth.enable = true;
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

  services = {
    logind = { settings.Login = { IdleAction = "suspend"; IdleActionSec = "1h"; }; };
    udev.packages = [
      pkgs.input-integrity
    ];
    udev.extraRules = ''
      KERNEL=="hidraw*", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0b05", ATTRS{idProduct}=="17cb", TAG+="uaccess", RUN+="/bin/sh -c 'echo -n %k > /sys/bus/usb/drivers/btusb/unbind'"
    ''; # bt adapter for wiimotes in dolphin

    hardware.openrgb.enable = true;
  };

  networking.usePredictableInterfaceNames = false; # I like eth0

  fileSystems = {
    "/boot" = { label = "boot"; fsType = "vfat"; };
    "/media/alt" = { label = "alt"; fsType = "btrfs"; options = [ "compress=zstd" ]; };
    "/media/windows" = { label = "windows"; fsType = "ntfs-3g"; };
    "/media/windata" = { label = "windata"; fsType = "ntfs-3g"; };
  };
}
