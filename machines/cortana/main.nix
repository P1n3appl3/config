{ pkgs, inputs, myOverlays, ... }: {
  imports = [
    ./hardware.nix
    ./web.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
    libraspberrypi
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs myOverlays; };
    users.joseph.imports = [
      ../../mixins/home-manager/common.nix
      ../../mixins/home-manager/linux.nix
      ../../mixins/home-manager/btrfs.nix
    ];
  };

  time.timeZone = "America/Los_Angeles";
  networking.hostName = "Cortana";
}
