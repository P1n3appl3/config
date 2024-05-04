{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup mold taplo
    cargo-edit cargo-expand cargo-udeps cargo-clone-crate cargo-audit
    cargo-modules cargo-bloat cargo-binutils twiggy bloaty
    ruff pyright
    beancount-language-server
    nasm asmfmt nasmfmt
    nurl nix-init
    typst typst-fmt typst-lsp
    j
    biome
  ];
}
