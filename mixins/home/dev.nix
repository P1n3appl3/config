{ pkgs, lib, config, ... } @ args: {
  options.dev.compilers = lib.mkOption {
    type = lib.types.bool; description = "Add compilers to home packages";
    default = builtins.hasAttr "osConfig" args;
  };

  config.home.packages = with pkgs; lib.mkMerge [ [
    taplo cargo-edit cargo-expand cargo-clone-crate cargo-udeps cargo-audit
    cargo-modules cargo-bloat cargo-binutils cargo-mommy # cargo-feature
    twiggy bloaty
    ruff pyright
    beancount-language-server
    asmfmt nasmfmt
    nurl nix-init
    typst tinymist typstyle
    biome
    j ] (lib.mkIf config.dev.compilers
      [ rustup mold-wrapped clang clang-tools nasm ])
  ];
}
