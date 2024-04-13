inputs: final: prev: {
  home-manager = prev.home-manager.overrideAttrs (old: {
    postInstall = ''
      substituteInPlace $out/bin/home-manager --replace-fail "nix build" "nom build"
    '';
  });

  nixos-rebuild = prev.nixos-rebuild.overrideAttrs (old: {
    postInstall = old.postInstall + ''
    substituteInPlace $out/bin/nixos-rebuild --replace-fail \
      'nix "''${flakeFlags[@]}" build' 'nom build'
    '';
  });

  eza = prev.eza.overrideAttrs (old: {
    patches = (old.patches or []) ++ [ (final.fetchpatch {
      url = "https://github.com/eza-community/eza/compare/main...P1n3appl3:eza:main.diff";
      hash = "sha256-TZnwIM8S4c0WeJtLEG1tFoKhqgMcE9top1S7Z7s9LeA=";
      }) ];
    doCheck = false;
  });

  # TODO: remove once https://github.com/doy/rbw/issues/165 is resolved
  rbw = prev.rbw.overrideAttrs (oldAttrs: {
      patches = oldAttrs.patches ++ [ (final.fetchpatch {
        name = "add-useragent.patch";
        url = "https://github.com/doy/rbw/files/14921243/patch.txt";
        sha256 = "sha256-SS+PTWA1UTsluts9Qtv+q3LJ22PTRUZ+usOB0aqz3Rk=";
      }) ];
  });
}
