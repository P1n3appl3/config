{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup sccache mold taplo
    cargo-edit cargo-expand cargo-udeps cargo-clone-crate cargo-audit
    cargo-bloat cargo-binutils twiggy bloaty
    ruff pyright
    beancount-language-server
    # TODO: create nix package for asm-lsp and add goto def
    nasm asmfmt nasmfmt
    (nurl.override { mercurial=null; }) # TODO: https://github.com/nix-community/nix-init
    typst typst-lsp typst-fmt
    # j # TODO: debug (llvm update?)
    # TODO: test rust-rpxy
  ];
}
