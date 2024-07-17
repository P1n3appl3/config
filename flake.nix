{
  description = "nix configs for my computers";
  inputs = {
    nixpkgs.url            = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url       = "github:nix-community/home-manager";
    flake-utils.url        = "github:numtide/flake-utils";
    nixos-hardware.url     = "github:NixOS/nixos-hardware";
    ragenix.url            = "github:yaxitech/ragenix";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nixgl.url              = "github:guibou/nixGL";
    rahul-config.url       = "github:rrbutani/nix-config";
    catppuccin.url         = "github:catppuccin/nix";
    slippi.url             = "github:lytedev/slippi-nix";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.inputs = { nixpkgs.follows = "nixpkgs"; flake-utils.follows = "flake-utils"; };
    ragenix.inputs = { nixpkgs.follows = "nixpkgs"; flake-utils.follows = "flake-utils"; };
    rahul-config.inputs = {
      nixpkgs.follows = "nixpkgs"; nixos-hardware.follows = "nixos-hardware";
      home-manager.follows = "home-manager"; flake-utils.follows = "flake-utils";
      nix-index-database.follows = "nix-index-database";
      agenix.follows = ""; ragenix.follows = ""; darwin.follows = "";
      impermanence.follows = "";
    };
    slippi.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, flake-utils, nixos-hardware, ragenix,
    nix-index-database, nixgl, rahul-config, catppuccin, slippi, self } @ inputs:
  let
    inherit (nixpkgs) lib;
    listDir = rahul-config.lib.util.list-dir;
    myOverlays = [
      self.overlays.default nixgl.overlays.default ragenix.overlays.default
      (import ./overlays.nix inputs)
    ];

    home = system: module: home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit inputs myOverlays; };
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./mixins/home/common.nix module ] ++
        builtins.attrValues self.outputs.homeModules;
    };

    machine = system: module: lib.nixosSystem {
      inherit system; specialArgs = { inherit inputs myOverlays; };
      modules = [ ./mixins/nixos/common.nix module ] ++
        builtins.attrValues self.outputs.nixosModules;
    };
  in {
    homeConfigurations = {
      ATLAS     = home "x86_64-linux"   ./machines/atlas.nix;
      clu       = home "x86_64-linux"   ./machines/clu.nix;
      rinzler   = home "x86_64-linux"   ./machines/rinzler.nix;
      crabapple = home "aarch64-darwin" ./machines/crabapple.nix;
    };

    nixosConfigurations = {
      Cortana = machine "aarch64-linux" ./machines/cortana/main.nix;
      WOPR    = machine "x86_64-linux"  ./machines/wopr/main.nix;
      HAL     = machine "x86_64-linux"  ./machines/hal/main.nix;
      ISO     = machine "x86_64-linux"  ./machines/iso.nix;
    };

    homeModules  = listDir { of = ./modules/home;  mapFunc = _: import; };
    nixosModules = listDir { of = ./modules/nixos; mapFunc = _: import; };

    overlays.default = final: _: listDir {
      of = ./pkgs; mapFunc = _: p: final.callPackage p {};
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
