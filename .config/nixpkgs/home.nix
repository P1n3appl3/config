{ pkgs, inputs, lib, ... }: {
  home.username = "joseph";
  home.homeDirectory = "/home/joseph";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions
    direnv nix-zsh-completions nix-your-shell
    # Utils
    fzf sysz ripgrep fd bat exa sd dogdns rm-improved ouch jq
    xh gh rbw hyperfine hexyl choose tokei git delta zellij rsync
    git-heatmap git-absorb lowcharts so
    # System info
    ncdu duf du-dust htop lm_sensors bottom bandwhich usbtop procs powertop
    # Language tools
    python3 mold bear lldb clang-tools_14 lld_14 nil bloaty taplo 
    shfmt shellcheck stylua sumneko-lua-language-server black ruff
    # Rust
    rustup rust-analyzer sccache (lib.lowPrio measureme)
    cargo-edit cargo-expand cargo-outdated cargo-udeps cargo-watch
    cargo-bloat cargo-llvm-lines cargo-flamegraph cargo-clone cargo-play
    # Nix
    nix nix-output-monitor nix-tree nix-direnv cachix
  ];

  imports = [
    ./vim.nix

    (let # use a minimal locale-archive without the full 200MB of locales
      a = lib.mkForce "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive";
    in {
      systemd.user.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
      home.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
    })
  ];

  nixpkgs.overlays = [ (final: prev: {
    fzf = prev.fzf.overrideAttrs ( prev: { # patch out perl dep
      postInstall = prev.postInstall + "rm $out/share/fzf/key-bindings.bash";
    });
  })];

  # use the nixpkgs version from this flake for my nixpkgs channel (for things
  # like `nix-shell`) and registry (for things like `nix shell`)
  home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs.outPath}";
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
