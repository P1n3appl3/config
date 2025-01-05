{ pkgs, lib, ... }: {
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
    wezterm.headless
  ];

  catppuccin.enable = lib.mkForce false;

  time.timeZone = "America/Los_Angeles";
  networking.hostName = "Cortana";
}
