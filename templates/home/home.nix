{ pkgs, inputs, config, myOverlays, ... }: {
  # Here's your list of packages, adding something to here and
  # rebuilding your config should be enough to make it available.
  home.packages = with pkgs; [
    # some utils I figure you'll want
    ripgrep fd bat eza jq htop bottom ncdu duf

    # some nix-specific tools
    nix home-manager nix-output-monitor nix-tree nil comma
  ];

  # this is the output that home-manager uses for "managed" stuff, when you want to start messing
  # with that you can go to https://mipmip.github.io/home-manager-option-search and look under
  # programs.<name> or services.<name> for all the relevant options.
  programs = {
    direnv = { enable = true; nix-direnv.enable = true; };
  };

  # finally for stuff that runs as a daemon you'll want to look under the services option
  services = {
    # records your clipboard history
    clipmenu.enable = true;
  };

  # everything else here is pretty much boilerplate that you don't really have to worry about
  # if you just wanna start sticking packages in your PATH.

  home = rec {
    username = "jspspike"; homeDirectory = "/home/${username}"; stateVersion = "23.11";
    # you can set env vars in your config. It's a tiny bit finicky and there's a
    # couple different ways to do it but this is the simplest assuming it works
    sessionVariables = {
      WEE = "WOO"; # echo $WEE to check if it's working :P
      # this uses your nixpkgs version for old-style nix-shell commands
      NIX_PATH = "nixpkgs=flake:nixpkgs";
    };

    # You can use the file option as a blunt tool to programatically generate files
    # if you need that. I personally have a little nix function that symlinks in all my
    # dotfiles from my config repo to my home dir, but if you're happy with still using
    # a bare repo for the dotfiles then don't worry about it.
    file."Downloads/blah".text = "weewoo";
  };

  # when you use something like `nix run nixpkgs#htop`, the registry is where nix looks up
  # the thing on the left hand side
  nix.registry = {
    # you generally want your `nix shell` and `nix run` to use the same version of nixpkgs
    # that your home configuration is using, that way you don't have to redownload slightly
    # different versions of a bunch of stuff.
    nixpkgs.flake = inputs.nixpkgs;
    # this is just a QOL entry that lets you refer to your flake by name rather than
    # by path. it'll let you do stuff like `nix flake update config` and `nix run config#eggnogg`
    config.to = { type = "git"; url = "file://${config.home.homeDirectory}/wherever"; };
  };

  imports = [
    inputs.nix-index-database.hmModules.nix-index
    # if you end up configuring stuff with home-manager it's helpful to stick related bits
    # in their own modules and you can organize them however you want. Those modules
    # get merged in a pretty elegant way, as a trivial example if you were to define
    # `home.packages = [ foo ]` in another module it'd concatenate those lists, but much
    # more powerful interactions are possible (a shell util module could check if you've
    # got zsh enabled and turn on some optional setting only in that case, etc.).
    # Eventually this list could look like: ./nvim.nix ./graphical-environment.nix etc.
  ];

  # friends don't let friends use proprietary software, but just in case:
  nixpkgs.config.allowUnfree = true;

  # apply your modifications
  nixpkgs.overlays = import ./overlays.nix inputs;
}
