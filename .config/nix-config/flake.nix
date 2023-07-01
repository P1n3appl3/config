{
  description = "my home-manager config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";

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

  outputs = { nixpkgs, home-manager, flake-utils,
              nix-index-database, rahul-config, self } @ inputs:
  let
    listDir = rahul-config.lib.util.list-dir {inherit (nixpkgs) lib;};
    home = system: module:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
        modules = [ ./home.nix nix-index-database.hmModules.nix-index module ];
        extraSpecialArgs = { inherit inputs; };
      };
  in {
      homeConfigurations = {
        HAL       = home "x86_64-linux"   ./hosts/hal.nix;
        ATLAS     = home "x86_64-linux"   ./hosts/atlas.nix;
        # WOPR    = home "x86_64-linux"   ./hosts/wopr.nix;
        clu       = home "x86_64-linux"   ./hosts/clu.nix;
        rinzler   = home "x86_64-linux"   ./hosts/rinzler.nix;
        crabapple = home "aarch64-darwin" ./hosts/crabapple.nix;
      };
      nixosConfigurations = {
        cortana = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux"; modules = [ ./hosts/cortana/configuration.nix ];
        };
      };
      overlays.default = final: _: listDir
        {of = ./pkgs; mapFunc = _: p: final.callPackage p {};};
    } // (flake-utils.lib.eachDefaultSystem (system :
      let
        pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
      in { packages = listDir {of = ./pkgs; mapFunc = n: _: pkgs.${n};}; })
    );
}
