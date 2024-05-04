inputs: final: prev: {
  eza = prev.eza.overrideAttrs (old: {
    patches = (old.patches or []) ++ [ (final.fetchpatch {
      url = "https://github.com/eza-community/eza/compare/main...P1n3appl3:eza:main.diff";
      hash = "sha256-TZnwIM8S4c0WeJtLEG1tFoKhqgMcE9top1S7Z7s9LeA=";
      }) ];
    doCheck = false;
  });

  # TODO: remove when they do a new release
  wpaperd = final.callPackage "${ final.fetchFromGitHub {
      owner = "danyspin97"; repo = "wpaperd";
      rev = "cd9eb31377da0029e6abfbf6e7f433476f50007e";
      hash = "sha256-5KB1lcGoKzslMduNFiFFEOzpkv//uDTynPSrrxa7mVw=";
    }
  }/nix" { };
}
