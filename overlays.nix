inputs: final: prev: let
  warnIfUpdated = (p: vOld: vNew: final.lib.warnIf (p.version != vOld)
    "nixpkgs updated ${p.name or p.pname}, might want to check your override" vNew);
in {
  fzf = prev.fzf.overrideAttrs ( old: {
    postInstall = old.postInstall + ''
      rm $out/share/fzf/key-bindings.bash
      rm $out/share/nvim/site/plugin/fzf.vim
      '';
  });

  home-manager = prev.home-manager.overrideAttrs (old: {
    postInstall = ''
      substituteInPlace $out/bin/home-manager --replace "nix build" "nom build"
    '';
  });

  nixos-rebuild = prev.nixos-rebuild.overrideAttrs (old: {
    postInstall = old.postInstall + ''
    substituteInPlace $out/bin/nixos-rebuild --replace \
      'nix "''${flakeFlags[@]}" build' 'nom build'
    '';
  });

  # This is mostly for https://git.pwmt.org/pwmt/zathura/-/merge_requests/80
  # which has since landed, so this whole overlay can be removed when they cut a release.
  zathura = (prev.zathura.override (old: {
    zathura_core = old.zathura_core.overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [final.json-glib];
      nativeBuildInputs = old.nativeBuildInputs ++ [final.xvfb-run];
      doCheck = false;
      src = final.fetchFromGitHub {
        owner = "pwmt"; repo = "zathura";
        rev = "9ab68dd1ee3640e56e4e4575112fcae44f8e40ca";
        hash = "sha256-YkpTpuQFjrDNvqTgzBhydX7a5Rsz5M7WjwdDxXaMiEk=";
      };
      version = warnIfUpdated old "0.5.2" "2023-11-05";
    });
  }));

  eza = prev.eza.overrideAttrs (old: {
    patches = (old.patches or []) ++ [ (final.fetchpatch {
      url = "https://github.com/eza-community/eza/compare/main...P1n3appl3:eza:main.diff";
      hash = "sha256-TZnwIM8S4c0WeJtLEG1tFoKhqgMcE9top1S7Z7s9LeA=";
      }) ];
    doCheck = false;
  });
}
