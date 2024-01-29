{
  description = "nix configs for my computers";
  inputs = {
    nixpkgs.url            = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url     = "github:NixOS/nixos-hardware";
    flake-utils.url        = "github:numtide/flake-utils";
    home-manager.url       = "github:nix-community/home-manager";
    nixgl.url              = "github:guibou/nixGL";
    nix-index-database.url = "github:Mic92/nix-index-database";
    rahul-config.url       = "github:rrbutani/nix-config";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.inputs.flake-utils.follows = "flake-utils";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    rahul-config.inputs = {
      nixpkgs.follows = "nixpkgs"; home-manager.follows = "";
      nix-index-database.follows = ""; ragenix.follows = ""; darwin.follows = "";
      impermanence.follows = ""; nixos-hardware.follows = "";
    };
  };
  outputs = { nixpkgs, home-manager, flake-utils, nixos-hardware,
    nix-index-database, nixgl, rahul-config, self } @ inputs:
  let
    inherit (nixpkgs) lib;
    listDir = rahul-config.lib.util.list-dir {inherit lib;};
    myOverlays = [
      self.overlays.default
      nixgl.overlay
      (import ./overlays.nix inputs)
    ];

    home = system: module: home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit inputs myOverlays; };
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./mixins/home/common.nix module ] ++
        builtins.attrValues self.outputs.homeModules;
    };

    machine = system: module: lib.nixosSystem {
      inherit system; specialArgs = {inherit inputs myOverlays; };
      modules = [ ./mixins/nixos/common.nix module ] ++
        builtins.attrValues self.outputs.nixosModules;
    };
  in {
    homeConfigurations = {
      HAL       = home "x86_64-linux"   ./machines/hal.nix;
      ATLAS     = home "x86_64-linux"   ./machines/atlas.nix;
      clu       = home "x86_64-linux"   ./machines/clu.nix;
      rinzler   = home "x86_64-linux"   ./machines/rinzler.nix;
      crabapple = home "aarch64-darwin" ./machines/crabapple.nix;
    };

    nixosConfigurations = {
      Cortana = machine "aarch64-linux" ./machines/cortana/main.nix;
      WOPR    = machine "x86_64-linux"  ./machines/wopr/main.nix;
    };

    homeModules = {};
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
}
