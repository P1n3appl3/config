{ pkgs, inputs, lib, ... }: {
  home.username = "joseph";
  home.homeDirectory = "/home/joseph";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions
    direnv nix-zsh-completions nix-your-shell
    # Utils
    fzf sysz ripgrep fd bat exa sd dogdns rm-improved ouch jq
    xh gh rbw hyperfine hexyl choose tokei git delta zellij rsync
    barchart git-heatmap git-absorb lowcharts so zstd util-linux
    trippy blahaj lolcat fortune cowsay
    # System info
    htop lm_sensors bottom bandwhich usbtop procs powertop
    # Storage
    smartmontools btrfs-progs compsize duperemove btdu duf ncdu du-dust
    # Language tools
    nil bloaty taplo bear mold ruff black pyright # lld_14 lldb clang-tools_14
    shfmt shellcheck stylua sumneko-lua-language-server
    # Rust
    rustup sccache (lib.lowPrio measureme)
    cargo-edit cargo-expand cargo-udeps cargo-watch cargo-clone-crate
    cargo-play cargo-bloat cargo-llvm-lines # cargo-flamegraph
    # Nix
    nix nix-output-monitor nix-tree nix-direnv cachix nurl
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
    fzf = prev.fzf.overrideAttrs ( self: { # patch out perl dep
      postInstall = self.postInstall + "rm $out/share/fzf/key-bindings.bash";
    });
  })];

  # use the nixpkgs version from this flake for my nixpkgs channel (for things
  # like `nix-shell`) and registry (for things like `nix shell`)
  home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs.outPath}";
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
