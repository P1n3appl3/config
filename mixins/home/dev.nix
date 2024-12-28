{ pkgs, pkgs-stable, lib, config, ... } @ args: {
  options.dev.compilers = lib.mkOption {
    type = lib.types.bool; description = "Add compilers to home packages";
    default = builtins.hasAttr "osConfig" args;
  };

  config.home.packages = with pkgs; lib.mkMerge [ [
    cargo-edit cargo-expand cargo-clone-crate cargo-udeps cargo-audit
    cargo-modules cargo-bloat cargo-binutils cargo-mommy cargo-feature
    cargo-show-asm
    taplo
    # term-rustdoc

    twiggy bloaty
    gdb rr lldb vscode-extensions.vadimcn.vscode-lldb.adapter
    ruff pyright (python3.withPackages (p: with p; [ debugpy ]))
    beancount-language-server
    asmfmt nasmfmt
    nurl nix-init
    typst tinymist typstyle
    biome
  ] (lib.mkIf config.dev.compilers
      [ rustup mold-wrapped clang clang-tools nasm ])
      (with pkgs-stable; [])
  ];
}
