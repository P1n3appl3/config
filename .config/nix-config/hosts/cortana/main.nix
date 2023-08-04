{ pkgs, inputs, ... } : {
  imports = [
    ../../nixos-modules/common.nix
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

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
  # TODO: fail2ban or something to block the bots knocking on my door

  environment.systemPackages = with pkgs; [
    acme-sh
  ];
}
