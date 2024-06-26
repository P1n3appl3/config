{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup mold taplo
    cargo-edit cargo-expand cargo-clone-crate cargo-udeps cargo-audit
    cargo-modules cargo-bloat cargo-binutils twiggy bloaty
    ruff pyright
    clang clang-tools
    beancount-language-server
    nasm asmfmt nasmfmt
    nurl nix-init
    typst typst-fmt typst-lsp
    biome
    j
  ];
}
