{
  imports = [ ../../mixins/nixos/btrfs.nix ];

  services = {
    fwupd.enable = true;
    # from https://www.worldofbs.com/nixos-framework, TODO: tweak
    tlp = { enable = true;
      settings = {
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_BATTERY = "powersave";
        START_CHARGE_THRESH_BAT0 = 90;
        STOP_CHARGE_THRESH_BAT0 = 97;
        RUNTIME_PM_ON_BAT = "auto";
      };
    };
    # TODO: figure out why this is on/conflicts with tlp
    power-profiles-daemon.enable = false;
    logind = {
      lidSwitch = "suspend-then-hibernate";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        IdleAction=suspend-then-hibernate
        IdleActionSec=10m
      '';
      powerKey = "hibernate";
    };
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=4h";

  # TODO: reenable once I check that it doesn't mess with tlp
  # powerManagement.powertop.enable = true;

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
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  networking.usePredictableInterfaceNames = false; # I like wlan0

  fileSystems = {
    "/boot" = { label = "boot"; fsType = "vfat"; };
  };
}
