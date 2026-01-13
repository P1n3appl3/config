inputs: final: prev: {
  eza = prev.eza.overrideAttrs (old: {
    patches = (old.patches or []) ++ [ (final.fetchpatch {
      url = "https://github.com/eza-community/eza/compare/main...P1n3appl3:eza:main.diff";
      hash = "sha256-qYe0Vax+OQSjS9td3jOJ6OcxQiNxaCrTUf3mC3grjro=";
    }) ];
    doCheck = false;
  });

  m-overlay = prev.m-overlay.overrideAttrs {
    version = "2024-08-26";
    src = final.fetchFromGitHub {
      owner = "p1n3appl3"; repo = "m-overlay";
      rev = "0747cf1a19d1f3cce5943c67d1eb7cab529f78a7";
      hash = "sha256-PV1i+n/lGK85To2PJfbwHIbm+XHHTxE3XCEX9rvupAE=";
    };
  };

  pokefinder = prev.pokefinder.overrideAttrs {
    version = "4.2.1";
    src = final.fetchFromGitHub {
      owner = "Admiral-Fish";
      repo = "PokeFinder";
      rev = "v4.2.1";
      sha256 = "sha256-wjHqox0Vxc73/UTcE7LSo/cG9o4eOqkcjTIW99BxsAc=";
      fetchSubmodules = true;
    };
    patches = [];
  };

  fishPlugins = prev.fishPlugins // { puffer = prev.fishPlugins.puffer.overrideAttrs {
    version = "mine";
    src = final.fetchFromGitHub {
      owner = "P1n3appl3";
      repo = "puffer-fish";
      rev = "83174b07de60078be79985ef6123d903329622b8";
      hash = "sha256-Dhx5+XRxJvlhdnFyimNxFyFiASrGU4ZwyefsDwtKnSg=";
    };
  };};

  # # for oneko
  # sway = prev.sway.overrideAttrs (old: {
  #   patches = (old.patches or []) ++ [ (final.fetchpatch {
  #       url = "https://catgirl.ai/log/sway-spy/spy.patch";
  #       hash = "sha256-CKGohz5eRMpMsorXh4G8eON3YmWjDW+WlXs2Pg3qIp8=";
  #     })
  #   ];
  # });
}
