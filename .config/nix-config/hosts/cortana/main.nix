{ pkgs, inputs, ... } : {
  imports = [
    ../../nixos-modules/common.nix
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  # TODO: why don't my overlays get applied to pkgs from home manager (e.g. fzf still has perl dep)
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users.joseph = {
      imports = [
        ../../home-modules/common.nix
        ../../home-modules/linux.nix
        ../../home-modules/btrfs.nix
      ];
    };
  };

  networking = {
    hostName = "Cortana";
    firewall.allowedTCPPorts = [ 22 ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  # TODO: fail2ban/ban2bgp/heimdall to ban the bots

  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
    libraspberrypi
    acme-sh
  ];
}
