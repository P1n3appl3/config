{
  description = "my home-manager config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, flake-utils, nix-index-database, self }:
  flake-utils.lib.eachDefaultSystem (system :
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      legacyPackages.homeConfigurations.joseph = 
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            ./home.nix
            nix-index-database.hmModules.nix-index
          ];
        };
    }
  );
}
