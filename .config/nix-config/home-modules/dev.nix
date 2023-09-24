{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup sccache mold measureme taplo
    cargo-edit cargo-expand cargo-udeps cargo-clone-crate
    cargo-bloat cargo-binutils twiggy bloaty
    bear
    ruff black pyright
    beancount-language-server
  ];
}
