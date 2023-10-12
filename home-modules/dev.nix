{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup sccache mold measureme taplo
    cargo-edit cargo-expand cargo-udeps cargo-clone-crate cargo-audit
    cargo-bloat cargo-binutils twiggy bloaty
    ruff black pyright
    beancount-language-server
    vale
    # TODO: create nix package for asm-lsp and add goto def
    nasm asmfmt nasmfmt # TODO: add neoformat for nasmfmt
  ];
}
