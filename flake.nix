{
  description = "nix configs for my computers";
  inputs = {
    nixpkgs.url            = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url     = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url       = "github:nix-community/home-manager";
    flake-utils.url        = "github:numtide/flake-utils";
    nixos-hardware.url     = "github:NixOS/nixos-hardware";
    ragenix.url            = "github:yaxitech/ragenix";
    nix-index-database.url = "github:Mic92/nix-index-database";

    sorcery.url            = "git+https://git.t4t.associates/char/sorcery?shallow=1";
    noctalia.url           = "github:noctalia-dev/noctalia-shell";
    catppuccin.url         = "github:catppuccin/nix";
    slippi.url             = "github:lytedev/slippi-nix";
    tgm.url                = "github:p1n3appl3/mame-tgm";
    # TODO: swap back from fork once lazymc is merged
    nix-minecraft.url      = "github:p1n3appl3/nix-minecraft/lazymc";
    obs-gamepad.url        = "github:p1n3appl3/obs-gamepad";
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, flake-utils, ragenix,
  self, obs-gamepad, nix-minecraft, tgm, noctalia, ... } @ inputs:
  let
    inherit (nixpkgs) lib;
    mapDir = lib.filesystem.packagesFromDirectoryRecursive;
    system = "x86_64-linux";
    special = {
      pkgs-stable = import nixpkgs-stable { inherit system;  config.allowUnfree = true; };
      inherit inputs self;
    };

    home = module: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = special;
      modules = [ ./mixins/home/common.nix module ] ++
        builtins.attrValues self.outputs.homeModules;
    };

    machine = module: lib.nixosSystem {
        inherit system; specialArgs = special;
        modules = [
          ./mixins/nixos/common.nix module
          { home-manager.extraSpecialArgs = special; }
        ] ++ builtins.attrValues self.outputs.nixosModules;
      };
  in {
    homeConfigurations = {
      ATLAS = home ./machines/atlas.nix;
      guest = home ./machines/guest.nix;
    };

    nixosConfigurations = {
      Cortana = machine ./machines/cortana/main.nix;
      WOPR    = machine ./machines/wopr/main.nix;
      HAL     = machine ./machines/hal/main.nix;
      ISO     = machine ./machines/iso.nix;
    };

    # homeModules  = mapDir { directory = ./modules/home; callPackage = import; };
    # nixosModules = mapDir { directory = ./modules/nixos; callPackage = import; };
    homeModules = {
      awawausb = import ./modules/home/awawausb.nix;
      fightcade = import ./modules/home/fightcade.nix;
    };
    nixosModules = {
      m-overlay = import ./modules/nixos/m-overlay.nix;
      porkbun-ddns = import ./modules/nixos/porkbun-ddns.nix;
      rust-rpxy = import ./modules/nixos/rust-rpxy.nix;
      sorcery = import ./modules/nixos/sorcery.nix;
    };

    overlays.default = let myPackages = final: _: mapDir {
      directory = ./pkgs; inherit (final) callPackage;
    }; in lib.composeManyExtensions [
      ragenix.overlays.default nix-minecraft.overlay
      obs-gamepad.overlays.default noctalia.overlays.default
      (import ./overlays.nix) myPackages
    ];

  } // (flake-utils.lib.eachSystem (with flake-utils.lib.system; [ x86_64-linux aarch64-linux ])
    (system: let
      pkgs = import nixpkgs { inherit system; 
        overlays = [ self.overlays.default ];
        config.allowUnfree = true;
      };
    in with lib; rec {
      packages = (pipe ./pkgs [
        (dir: mapDir { directory = dir; inherit (pkgs) callPackage; })
        (filterAttrs (_: meta.availableOn pkgs.stdenv.hostPlatform))
        (filterAttrs (_: p: !(p.meta.broken or false)))
      ]) // { inherit (pkgs) eza gdu ragenix chhoto-url; }; # just for caching

      ci = (pipe self.nixosConfigurations [
        (lib.filterAttrs (_: v: v.config.nixpkgs.system == system))
        (lib.mapAttrs (_: v: v.config.system.build.toplevel))
      ]) // packages;
    })
  );

  nixConfig = {
    extra-substituters = [ "https://pineapple.cachix.org" ];
    extra-trusted-public-keys = [
      "pineapple.cachix.org-1:FjFjdb26PFCZL09M2yHiPw1J+c1Ab9AbpfnFeTpzNQk="
    ];
  };

  # let me put this in the lock file or smth >:(
  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.inputs.nixpkgs.follows = "nixpkgs";
    ragenix.inputs = {
      nixpkgs.follows = "nixpkgs-stable"; flake-utils.follows = "flake-utils";
      agenix.inputs.home-manager.follows = "home-manager";
    };
    slippi.inputs = {
      nixpkgs.follows = "nixpkgs"; home-manager.follows = "home-manager";
      git-hooks.follows = "";
    };
    tgm.inputs.nixpkgs.follows = "nixpkgs-stable";
    sorcery.inputs.nixpkgs.follows = "nixpkgs";
    noctalia.inputs.nixpkgs.follows  = "nixpkgs";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    obs-gamepad.inputs.nixpkgs.follows = "nixpkgs";
  };
}
