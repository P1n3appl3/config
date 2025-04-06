{
  description = "nix configs for my computers";
  inputs = {
    nixpkgs.url            = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url     = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url       = "github:nix-community/home-manager";
    nix-darwin.url         = "github:LnL7/nix-darwin/master";
    flake-utils.url        = "github:numtide/flake-utils";
    nixos-hardware.url     = "github:NixOS/nixos-hardware";
    ragenix.url            = "github:yaxitech/ragenix";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nixgl.url              = "github:guibou/nixGL";
    mac-app-util.url       = "github:hraban/mac-app-util";
    catppuccin.url         = "github:catppuccin/nix";
    slippi.url             = "github:lytedev/slippi-nix";
    obs-gamepad.url        = "github:p1n3appl3/obs-gamepad";
    rahul-config.url       = "github:rrbutani/nix-config";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.inputs = { nixpkgs.follows = "nixpkgs"; flake-utils.follows = "flake-utils"; };
    mac-app-util.inputs = { nixpkgs.follows = "nixpkgs"; flake-utils.follows = "flake-utils"; };
    ragenix.inputs = { nixpkgs.follows = "nixpkgs"; flake-utils.follows = "flake-utils"; };
    slippi.inputs = {
      nixpkgs.follows = "nixpkgs"; home-manager.follows = "home-manager";
      git-hooks.follows = "";
    };
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
    obs-gamepad.inputs.nixpkgs.follows = "nixpkgs";
    rahul-config.inputs = {
          nixpkgs.follows = "nixpkgs"; nixos-hardware.follows = "nixos-hardware";
          home-manager.follows = "home-manager"; flake-utils.follows = "flake-utils";
          nix-index-database.follows = "nix-index-database";
          agenix.follows = ""; ragenix.follows = ""; darwin.follows = "";
          impermanence.follows = "";
        };
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, nix-darwin, flake-utils,
    ragenix, nixgl, obs-gamepad, self, rahul-config, ... } @ inputs:
  let
    inherit (nixpkgs) lib;
    listDir = rahul-config.lib.util.list-dir;
    mapDir = lib.filesystem.packagesFromDirectoryRecursive;
    myOverlays = [
      self.overlays.default nixgl.overlays.default ragenix.overlays.default
      obs-gamepad.overlays.default (import ./overlays.nix inputs)
    ];
    special = system: {
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      inherit myOverlays inputs self;
    };

    home = system: module: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = special system;
      modules = [ ./mixins/home/common.nix module ] ++
        builtins.attrValues self.outputs.homeModules;
    };

    machine = system: module: if system == "aarch64-darwin" then
      (nix-darwin.lib.darwinSystem {
        inherit system; specialArgs = special system;
        modules = [
          module { home-manager.extraSpecialArgs = special system; }
        ];
      }) else (lib.nixosSystem {
        inherit system; specialArgs = special system;
        modules = [
          ./mixins/nixos/common.nix
          module { home-manager.extraSpecialArgs = special system; }
        ] ++ builtins.attrValues self.outputs.nixosModules;
      });
  in {
    homeConfigurations = {
      ATLAS = home "x86_64-linux" ./machines/atlas.nix;
    };

    nixosConfigurations = {
      Cortana = machine "aarch64-linux" ./machines/cortana/main.nix;
      WOPR    = machine "x86_64-linux"  ./machines/wopr/main.nix;
      HAL     = machine "x86_64-linux"  ./machines/hal/main.nix;
      ISO     = machine "x86_64-linux"  ./machines/iso.nix;
    };

    darwinConfigurations = {
      GLaDOS = machine "aarch64-darwin" ./machines/glados.nix;
    };

    homeModules  = listDir { of = ./modules/home;  mapFunc = _: import; };
    nixosModules = listDir { of = ./modules/nixos; mapFunc = _: import; };

    overlays.default = final: _: mapDir {
      directory = ./pkgs; callPackage = final.callPackage;
    };
  } // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
    in with lib; {
      packages = pipe ./pkgs [
        (dir: listDir { of = dir; mapFunc = p: _: pkgs.${p}; })
        (filterAttrs (_: meta.availableOn pkgs.hostPlatform))
        (filterAttrs (_: p: !(p.meta.broken or false)))
      ];
    })
  );

  nixConfig = {
    extra-substituters = [ "https://cache.garnix.io" "https://pineapple.cachix.org" ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "pineapple.cachix.org-1:FjFjdb26PFCZL09M2yHiPw1J+c1Ab9AbpfnFeTpzNQk="
    ];
  };
}
