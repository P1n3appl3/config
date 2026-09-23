{
  imports = [
    ../../mixins/nixos/btrfs.nix
  ];

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    cpu.intel.npu.enable = true;
    graphics.enable = true;
    bluetooth.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      branch = "legacy_580";
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  services.hardware.openrgb.enable = true;

  fileSystems = let
    subvol = name: opts: { label = "data"; fsType = "btrfs";
      options = [ "subvol=@${name}" ] ++ opts; };
    in {
    "/boot" = { label = "boot"; fsType = "vfat"; };
    "/git"    = subvol "git" [ "noatime" ];
    "/photos" = subvol "photos" [ ];
    "/website"= subvol "website" [ ];
    # "/mnt/data" = { device = "UUID=BE18B5B118B56953"; fsType = "ntfs-3g"; options = ["nofail"]; };
  };
}
