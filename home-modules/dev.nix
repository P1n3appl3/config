{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup sccache mold taplo
    cargo-edit cargo-expand cargo-udeps cargo-clone-crate cargo-audit
    cargo-bloat cargo-binutils twiggy bloaty
    ruff pyright
    beancount-language-server
    nasm asmfmt nasmfmt
    nurl nix-init
    typst typst-lsp typst-fmt
    # j
  ];
}
