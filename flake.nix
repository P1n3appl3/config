{
  description = "my NixOS and home-manager config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixgl.url = "github:guibou/nixGL";
    nixgl.inputs.flake-utils.follows = "flake-utils";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";

    rahul-config.url = "github:rrbutani/nix-config";
    rahul-config.inputs = {
      nixpkgs.follows = "nixpkgs"; home-manager.follows = "home-manager";
      ragenix.follows = ""; darwin.follows = ""; impermanence.follows = "";
      nixos-hardware.follows = ""; flu.follows = "flake-utils";
    };
  };
  # TODO: export home/nixos modules separately from hosts, see:
  # https://github.com/Misterio77/nix-starter-configs/blob/main/standard/flake.nix
  outputs = { nixpkgs, home-manager, flake-utils, nixos-hardware, nix-index-database,
              nixgl, rahul-config, self } @ inputs:
  let
    listDir = rahul-config.lib.util.list-dir {inherit (nixpkgs) lib;};
    myOverlays = [ self.overlays.default nixgl.overlay (import ./overlays.nix inputs) ];

    home = system: hostModule: home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit inputs myOverlays; };
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./home-modules/common.nix hostModule ];
    };

    machine = system: hostModule: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs myOverlays; };
      modules = [ ./nixos-modules/common.nix hostModule ];
    };
  in {
    homeConfigurations = {
      HAL       = home "x86_64-linux"   ./hosts/hal.nix;
      ATLAS     = home "x86_64-linux"   ./hosts/atlas.nix;
      clu       = home "x86_64-linux"   ./hosts/clu.nix;
      rinzler   = home "x86_64-linux"   ./hosts/rinzler.nix;
      crabapple = home "aarch64-darwin" ./hosts/crabapple.nix;
    };
    nixosConfigurations = {
      Cortana = machine "aarch64-linux" ./hosts/cortana/main.nix;
      WOPR    = machine "x86_64-linux"  ./hosts/wopr/main.nix;
    };
    overlays.default = final: _: listDir
      {of = ./pkgs; mapFunc = _: p: final.callPackage p {};};
  } // (flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
    in { packages = listDir {of = ./pkgs; mapFunc = n: _: pkgs.${n};}; })
  );
}
