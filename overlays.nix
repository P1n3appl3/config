inputs: final: prev: let
  # TODO: this seems to have stopped working?
  warnIfUpdated = (p: vOld: vNew: final.lib.warnIf (p.version != vOld)
    "nixpkgs updated ${p.name or p.pname}, go remove your overlay" vNew);
in {
  fzf = prev.fzf.overrideAttrs ( old: {
    postInstall = old.postInstall + ''
      rm $out/share/fzf/key-bindings.bash # TODO: remove once perl is gone
      rm $out/share/nvim/site/plugin/fzf.vim
      '';
  });

  # TODO: remove when they do a release so that
  # https://git.pwmt.org/pwmt/zathura/-/merge_requests/80 is in the nixpkgs one
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

  sd = (prev.sd.overrideAttrs (old: rec {
    # TODO: any way of avoiding IFD other than making it a flake=false flake input?
    # src = builtins.getFlake
    #   "github:chmln/sd/commit/cb015f749070e424d82e7f35fcad801cd4a5cbc7";
    src = final.fetchFromGitHub {
      owner = "chmln"; repo = "sd";
      rev = "cb015f749070e424d82e7f35fcad801cd4a5cbc7";
      hash = "sha256-6HfZnqNbZzEyj6Nnnp+XDdO7s1Iny3Tc29icjhZwp+M=";
    };
    version = warnIfUpdated old "0.7.6" "1.0-beta";
    cargoDeps = final.rustPlatform.importCargoLock { lockFile = "${src}/Cargo.lock"; };
  }));

  nix-output-monitor = prev.nix-output-monitor.overrideAttrs (old: {
    version = warnIfUpdated old "2.0.0.7" "patched"; # thanks rebecca!
    patches = (old.patches or []) ++ [ (final.fetchpatch {
          url = "https://github.com/maralorn/nix-output-monitor/pull/121.diff";
          hash = "sha256-kAG40QsG+lWCQfTKDqn4kz1Y6/x5P3p0Zc44H1QA/JQ=";
        })
      ];
  });

  home-manager = prev.home-manager.overrideAttrs (old: {
    postInstall = ''
      substituteInPlace $out/bin/home-manager --replace "nix build" "nom build"
    '';
  });

  # TODO: do the same for nixos-rebuild with nix-build:
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/os-specific/linux/nixos-rebuild/nixos-rebuild.sh

  # TODO: eza mins/secs
}
