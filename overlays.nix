inputs: final: prev: let
  warnIfUpdated = (p: vOld: vNew: final.lib.warnIf (p.version != vOld)
    "nixpkgs updated ${p.name}, go remove your overlay" vNew);
in {
  fzf = prev.fzf.overrideAttrs ( self: {
    postInstall = self.postInstall + ''
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

  typst-lsp = (prev.typst-lsp.overrideAttrs (old: rec {
    src = builtins.getFlake
      "github:nvarner/typst-lsp/cc7bad9bd9764bfea783f2fab415cb3061fd8bff";
    version = warnIfUpdated old "0.10.1" src.shortRev;
    cargoDeps = final.rustPlatform.importCargoLock {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "typst-0.9.0" = "sha256-LwRB/AQE8TZZyHEQ7kKB10itzEgYjg4R/k+YFqmutDc=";
        "typst-syntax-0.7.0" = "sha256-yrtOmlFAKOqAmhCP7n0HQCOQpU3DWyms5foCdUb9QTg=";
        "typstfmt_lib-0.2.6" = "sha256-UUVbnxIj7kQVpZvSbbB11i6wAvdTnXVk5cNSNoGBeRM=";
      };
    };
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

  # TODO: nom switch FE0E -> FE0F in output for emojis
  # TODO: eza mins/secs
}
