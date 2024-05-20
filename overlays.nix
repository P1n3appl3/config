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
}
