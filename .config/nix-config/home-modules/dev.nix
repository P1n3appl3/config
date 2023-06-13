{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup sccache mold measureme taplo
    cargo-edit cargo-expand cargo-udeps cargo-watch cargo-clone-crate
    cargo-play cargo-bloat cargo-flamegraph
    twiggy bloaty
    bear
    ruff black pyright
  ];
}
