{ pkgs, pkgs-stable, lib, config, ... } @ args: {
  options.dev = {
    compilers = lib.mkOption {
      type = lib.types.bool; description = "Install compiler toolchains";
      default = builtins.hasAttr "osConfig" args;
    };
    debuggers = lib.mkOption {
      type = lib.types.bool; description = "Install debuggers";
      default = builtins.hasAttr "osConfig" args;
    };
  };

  config.home.packages = with pkgs; lib.mkMerge [ [
    onefetch

    cargo-edit cargo-nextest cargo-mommy cargo-feature cargo-expand cargo-clone-crate
    cargo-udeps cargo-audit cargo-modules cargo-bloat cargo-binutils cargo-show-asm
    taplo
    # term-rustdoc

    elf-info
    twiggy bloaty

    (writeShellScriptBin "uv" ''env UV_PYTHON_PREFERENCE=only-system \
      UV_PYTHON="${python3}" ${lib.getExe uv} $@'')
    (lib.lowPrio uv) ruff pyright (python3.withPackages (p: with p; [ debugpy ]))
    beancount-language-server
    asmfmt nasmfmt
    nurl nix-init
    typst tinymist typstyle
    # biome # TODO: fix on GLaDOS, just check phase fails
    posting
  ]

  (lib.mkIf config.dev.compilers
    ([ rustup mold-wrapped clang clang-tools nasm ] ++
      lib.optionals stdenv.isLinux [ pkgs-stable.j ]))

  (lib.mkIf config.dev.debuggers
    ([ lldb vscode-extensions.vadimcn.vscode-lldb.adapter ] ++
      lib.optionals stdenv.isLinux [ gdb rr ]))
  ];
}
