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

  fishPlugins = prev.fishPlugins.overrideScope (self: super: {
    puffer = super.puffer.overrideAttrs (old: {
      version = "mine";

      src = final.fetchFromGitHub {
        owner = "P1n3appl3";
        repo = "puffer-fish";
        rev = "8e81dff4ee38168907311573d570b6c97870ea53";
        hash = "sha256-PZvUp7tFnzpvmJY5t+AtsHwL8ApXfKy3aqMP0Dupwpc=";
      };
    });
  });

  # # for oneko
  # sway = prev.sway.overrideAttrs (old: {
  #   patches = (old.patches or []) ++ [ (final.fetchpatch {
  #       url = "https://catgirl.ai/log/sway-spy/spy.patch";
  #       hash = "sha256-CKGohz5eRMpMsorXh4G8eON3YmWjDW+WlXs2Pg3qIp8=";
  #     })
  #   ];
  # });
}
