# Really flakes are just a structured way of enumerating a set of inputs
# and outputs. In this case you only care about one output (your homeConfiguration
# for your laptop) but I've added a "packages" output so that packages from your
# config are exposed and I can do something like `nix run github:jspspike/config#foo`
{
  description = "An example config";

  # These are the flakes that your config takes as an input, nixpkgs is of
  # course the big one, but any project that has a flake.nix can be added here which
  # gives you the ability to lock their version independently from the rest of nixpkgs.
  inputs = {

    # Picking which nixpkgs branch you use as an input (here I went with nixos-unstable)
    # will affect how aggressive `nix flake update` will be when repinning your deps.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # if you're curious about "follows", it's essentially making your transitive deps
    # use the same versions of things. The flake ecosystem is pretty young and they
    # don't have any sort of version resolver, so each flake just pins all its deps
    # to some hash and that would mean that every flake you use depends on a different
    # version of nixpkgs (as well as some other common flakes like flake-utils). Instead
    # we manually override the nixpkgs input of each of the flakes we depend on so at the
    # end of the day we end up with a single version used everywhere. You can see it in
    # action if you uncomment the above line and run `nix flake update`, then look at your
    # flake.lock, there will be a nixpkgs_1 and nixpkgs_2. It's not the end of the world
    # to use multiple versions of nixpkgs, but it can bog down evaluation time and increase
    # the amount of stuff you have to redownload or rebuild.

    # this one's a pre-populated index for easily looking up which (not currently installed)
    # packages have a certain file (like /bin/notify-send). While search.nixos.org is
    # usually the easiest thing, sometimes you'll want to run `nix-locate <some-path>` and
    # this will make it so you don't have to build an index for it yourself.
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, nix-index-database, self } @ inputs:
    let pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    homeConfigurations.my-home-config = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        inherit pkgs;
        modules = [ ./home.nix ];
    };

    # If you find some program you want in your config and it's not in nixpkgs, it's
    # usually not too hard to follow the build instructions for it and create your own
    # little package. Maybe it's a little more effort than cargo install or git
    # clone+configure+make install but on the bright side it's pretty much guaranteed to
    # stay working whereas your unmanaged self-built binaries would be a pain to keep up
    # to date or move to a new machine. I used nix-init to stick some random stuff in
    # there as an example.
    packages.x86_64-linux = nixpkgs.lib.packagesFromDirectoryRecursive {
      callPackage = pkgs.callPackage; directory = ./pkgs;
    };
  };
}

