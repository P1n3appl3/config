{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./web.nix
  ];

  home-manager.users.julia.imports = [
    ../../mixins/home/common.nix
    ../../mixins/home/linux.nix
    ../../mixins/home/btrfs.nix
  ];

  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
    libraspberrypi
  ];

  time.timeZone = "America/Los_Angeles";
  networking.hostName = "Cortana";
}
