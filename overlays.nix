inputs: final: prev: {
  eza = prev.eza.overrideAttrs (old: {
    patches = (old.patches or []) ++ [ (final.fetchpatch {
      url = "https://github.com/eza-community/eza/compare/main...P1n3appl3:eza:main.diff";
      hash = "sha256-TZnwIM8S4c0WeJtLEG1tFoKhqgMcE9top1S7Z7s9LeA=";
    }) ];
    doCheck = false;
  });

  # TODO: remove when they do a new release
  wpaperd = prev.wpaperd.overrideAttrs { src = builtins.getFlake
    "github:danyspin97/wpaperd?rev=204b1c550ad6bfa9f2b855de4666c3495d204420"; };

  m-overlay = prev.m-overlay.overrideAttrs {
    version = "2024-08-26";
    src = final.fetchFromGitHub {
      owner = "p1n3appl3"; repo = "m-overlay";
      rev = "0747cf1a19d1f3cce5943c67d1eb7cab529f78a7";
      hash = "sha256-PV1i+n/lGK85To2PJfbwHIbm+XHHTxE3XCEX9rvupAE=";
    };
  };
}
