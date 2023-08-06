{
  description = "my home-manager config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    rahul-config.url = "github:rrbutani/nix-config";
    rahul-config.inputs = {
      nixpkgs.follows = "nixpkgs"; home-manager.follows = "home-manager";
      ragenix.follows = ""; darwin.follows = ""; impermanence.follows = "";
      nixos-hardware.follows = ""; flu.follows = "flake-utils";
    };
  };
  nixConfig = {
    extra-substituters = "https://pineapple.cachix.org";
    extra-trusted-public-keys =
      "pineapple.cachix.org-1:FjFjdb26PFCZL09M2yHiPw1J+c1Ab9AbpfnFeTpzNQk=";
  };

  outputs = { nixpkgs, home-manager, flake-utils, nixos-hardware,
              nix-index-database, rahul-config, self } @ inputs:
  let
    listDir = rahul-config.lib.util.list-dir {inherit (nixpkgs) lib;};
    home = system: module: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
      modules = [ ./home-modules/common.nix module ];
      extraSpecialArgs = { inherit inputs; };
    };
    machine = system: module: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs; };
      modules = [
        home-manager.nixosModules.home-manager
        { nixpkgs.overlays = [ self.overlays.default ] ; }
        module
      ];
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
        testvm  = machine "x86_64-linux"  ./hosts/testvm.nix;
      };
      overlays.default = final: _: listDir
        {of = ./pkgs; mapFunc = _: p: final.callPackage p {};};
    } // (flake-utils.lib.eachDefaultSystem (system :
      let
        pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
      in { packages = listDir {of = ./pkgs; mapFunc = n: _: pkgs.${n};}; })
    );
}
