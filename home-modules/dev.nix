{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup sccache mold measureme taplo
    cargo-edit cargo-expand cargo-udeps cargo-clone-crate cargo-audit
    cargo-bloat cargo-binutils twiggy bloaty
    ruff pyright
    beancount-language-server
    # TODO: create nix package for asm-lsp and add goto def
    nasm asmfmt nasmfmt
    (nurl.override { mercurial=null; })
    typst typst-lsp typst-fmt
  ];
}
