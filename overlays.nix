inputs: final: prev: {
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
      src = final.fetchFromGitLab {
        domain = "git.pwmt.org"; owner = "pwmt"; repo = "zathura";
        rev = "9ab68dd1ee3640e56e4e4575112fcae44f8e40ca";
        hash = "sha256-YkpTpuQFjrDNvqTgzBhydX7a5Rsz5M7WjwdDxXaMiEk=";
      };
    });
  })).overrideAttrs { version = "HEAD"; };
  # TODO: remove when a release happens
  # getflake
  typst-lsp = (prev.typst-lsp.overrideAttrs (old: rec {
    src = inputs.typst-lsp;
    # version = final.lib.trace old.version old.version;
    version = final.lib.warnIf (old.version != "0.123")
      "Upstream updated typst-lsp, remove ur overlay" src.shortRev;
    cargoDeps = final.rustPlatform.importCargoLock {
      lockFile = "${src}/Cargo.lock";
      outputHashes = {
        "typst-0.9.0" = "sha256-LwRB/AQE8TZZyHEQ7kKB10itzEgYjg4R/k+YFqmutDc=";
        "typst-syntax-0.7.0" = "sha256-yrtOmlFAKOqAmhCP7n0HQCOQpU3DWyms5foCdUb9QTg=";
        "typstfmt_lib-0.2.6" = "sha256-UUVbnxIj7kQVpZvSbbB11i6wAvdTnXVk5cNSNoGBeRM=";
      };
    };
  }));
  # TODO: nom switch FE0E -> FE0F in output for emojis
  # TODO: eza mins/secs
}
