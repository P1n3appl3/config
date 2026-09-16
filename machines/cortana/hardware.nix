{
  imports = [
    ../../mixins/nixos/btrfs.nix
  ];

  hardware = {
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = true;
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  fileSystems = let
    subvol = name: opts: { label = "data"; fsType = "btrfs";
      options = [ "subvol=@${name}" ] ++ opts; };
    in {
    "/boot" = { label = "boot"; fsType = "vfat"; };
    "/git"    = subvol "git" [ "noatime" ];
    "/photos" = subvol "photos" [ ];
    "/website"= subvol "website" [ ];
  };
}
