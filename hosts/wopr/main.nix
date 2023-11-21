{ inputs, myOverlays, ... }: {
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  services = {
    pipewire = {
      enable = true; wireplumber.enable = true;
      alsa.enable = true; pulse.enable = true; jack.enable = true;
    };
    localtimed.enable = true;
    # TODO: sleep states, suspend to ram, hibernate, lid close and idle time
    # upower = { enable = true; criticalPowerAction = "Hibernate"; };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs myOverlays; };
    users.joseph.imports = [
      ../../home-modules/common.nix
      ../../home-modules/linux.nix
      ../../home-modules/btrfs.nix
      ../../home-modules/dev.nix
      ../../home-modules/graphical/common.nix
      ../../home-modules/graphical/hyprland.nix
      ../../home-modules/graphical/music.nix
    ];
  };

  networking.hostName = "WOPR";
}
