{ nixpkgs, pkgs, system, self, ... } @ inputs: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  users.users.joseph = {
    isNormalUser = true;
    extraGroups = [ "joseph" "wheel" ];
    initialPassword = "changethis";
    openssh.authorizedKeys.keys = [''
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfVoCjrBTOH746bJCKQwRgWzjFskNeLQKz73
      qmd4P3tmiJIFMAim7MiCwtQbxvIUOTZHbG7vRHZ5SwSH/d/wqmESmY1meRH/43uP4YlRRwUFkU
      HcwEJsVP9dDza0jYuBXVo04B/fuP93W2+aeBPKiSuWrnQ9s2LwRJ/0aqani8xpVn87EXp90aXj
      dF4iqu7tL4Nn1zUULYOdULrry0j6moUumUhmtkWb0PrTcxZr7BoDz8UH7Fu9G0uK8Xr5dAxs7R
      gTyFpUWg6h+AKQczMHLluwuRr2m12gWXKZIVO+Sw1PYYuU58Y7+E00KEM1Xy9SnuOW5ZgnxWBq
      ydD+Gc2q67''];
  };
  # home-manager.users.joseph = {
  #   home = { username = "joseph"; homeDirectory = "/home/joseph"; };
  #   imports = [ ../home.nix ../home-modules/linux.nix ../home-modules/btrfs.nix ];
  #   inherit pkgs;
  # };
  pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 3;
      graphics = false;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  networking = {
    hostName = "Cortana";
    firewall.allowedTCPPorts = [ 22 ];
  };

  environment.systemPackages = with pkgs; [
    acme-sh
  ];

  system.stateVersion = "23.05";
}
