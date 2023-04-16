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
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
      ragenix.follows = "";
      darwin.follows = "";
      impermanence.follows = "";
    };
  };

  outputs = { nixpkgs, home-manager, flake-utils,
              nix-index-database, rahul-config, self } @ inputs:
  let 
    listDir = rahul-config.lib.util.list-dir {inherit (nixpkgs) lib;};
  in
    (flake-utils.lib.eachDefaultSystem (system :
      let
        pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
      in {
        legacyPackages.homeConfigurations.joseph = 
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ 
              ./home.nix
              nix-index-database.hmModules.nix-index
            ];
            extraSpecialArgs = { inherit inputs; };
          };

        packages = listDir {of = ./pkgs; mapFunc = n: _: pkgs.${n};};

      }
      )) // {
        overlays.default = final: _: listDir
          {of = ./pkgs; mapFunc = _: p: final.callPackage p {};};
    };
}
