{ pkgs ? import <nixpkgs> { }, nixPlugins ? [ "fzf-lua" ]
, githubPlugins ? [{
  owner = "kalcutter";
  repo = "vim-gn";
}], }:
let
  inherit (pkgs) lib;
  _ignores = with builtins;
    lib.pipe
    "${pkgs.path}/pkgs/applications/editors/vim/plugins/deprecated.json" [
      readFile
      fromJSON
      attrNames
    ];
  plugs = lib.pipe pkgs.vimPlugins [
    # (lib.filterAttrs (n: _: !(builtins.elem n (ignores ++ ["vim-sourcetrail"]))))
    (lib.filterAttrs (n: _: (builtins.elem n nixPlugins)))
  ];
  flakeInputs = let
    fromNix = builtins.mapAttrs (_: v:
      assert (lib.hasPrefix "https://gith" v.src.url); {
        inherit (v.src) owner repo;
      }) plugs;
    fromGithub = builtins.listToAttrs (map (p: {
      name = p.repo;
      value = p;
    }) githubPlugins);
    all = lib.attrsets.unionOfDisjoint fromNix fromGithub;

    toInput = name:
      { owner, repo }: ''
        ${name} = {
          url = github:${owner}/${repo};
          flake = false;
        };
      '';
  in ''
    inputs = {
      flake-utils.url = github:numtide/flake-utils; 
      nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
      ${builtins.concatStringsSep "" (lib.mapAttrsToList toInput all)}
    };
  '';

  flakeOutputs = let
    fromNix = lib.pipe nixPlugins [
      (map (name:
        "\n      ${name} = np.vimPlugins.${name}.overrideAttrs (self: {\n src = inputs.${name};\n });\n "))
      (builtins.concatStringsSep "\n")
    ];

    fromGithub = lib.pipe githubPlugins [
      (map ({ repo, ... }: repo)) # get names
      (map (name: ''
        ${name} = buildVimPluginFrom2Nix {
          pname = "${name}";
          version = inputs.${name}.lastModifiedDate;
          src = inputs.${name};
        };
      ''))
      (builtins.concatStringsSep "\n")
    ];
  in ''
    outputs = { nixpkgs, flake-utils, ... }@inputs: flake-utils.lib.eachDefaultSystem (system: let
      np = nixpkgs.legacyPackages.''${system};
      inherit (np.vimUtils) buildVimPluginFrom2Nix;
    in rec {
      packages = vimPlugins;
      vimPlugins = {
        ${fromNix}
        ${fromGithub}
      };
    });
  '';

  flake = "{ " + flakeInputs + "\n\n" + flakeOutputs + " } ";
in pkgs.runCommand "gen-subflake" {
  nativeBuildInputs = [ pkgs.nixfmt ];
  inherit flake;
  passAsFile = [ "flake" ];
} ''
cp $flakePath $out
nixfmt $out 
''

