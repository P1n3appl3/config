{ pkgs, inputs, myOverlays, ... }: {
  imports = [
    ./hardware.nix
    ./web.nix
  ];

  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
    libraspberrypi
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs myOverlays; };
    users.julia.imports = [
      ../../mixins/home/common.nix
      ../../mixins/home/linux.nix
      ../../mixins/home/btrfs.nix
    ];
  };

  time.timeZone = "America/Los_Angeles";
  networking.hostName = "Cortana";
}
