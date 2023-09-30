# Run with:
# , nixos-shell --flake ~/.config/nix-config#testvm
{ inputs, ... } : {
  imports = [ ../nixos-modules/common.nix ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users.joseph = {
      imports = [ ../home-modules/common.nix ../home-modules/linux.nix ];
    };
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 3;
      graphics = false;
    };
  };
}
