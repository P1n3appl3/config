{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup sccache mold measureme taplo
    cargo-edit cargo-expand cargo-udeps cargo-clone-crate cargo-audit
    cargo-bloat cargo-binutils twiggy bloaty
    # TODO: remove black once ruff format lands
    ruff black pyright
    beancount-language-server
    # TODO: create nix package for asm-lsp and add goto def
    nasm asmfmt nasmfmt # TODO: add neoformat for nasmfmt
    (nurl.override { mercurial=null; })
    # TODO: lsp isn't finding typstfmt, fix config?
    typst typst-lsp typst-fmt
  ];
}
