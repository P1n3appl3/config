{ pkgs, inputs, config, lib, ... }: {
  home.username = "joseph";
  home.homeDirectory = "/home/joseph";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  home.sessionVariables = {
    LOCALE_ARCHIVE_2_27 = lib.mkForce config.systemd.user.sessionVariables.LOCALE_ARCHIVE_2_27;
    NIX_PATH = "nixpkgs=${inputs.nixpkgs.outPath}"; # use channel that matches flake input
  };
  nix.registry.nixpkgs.flake = inputs.nixpkgs; # use registry (for new-style cmds) matching flake input

  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions
    direnv nix-zsh-completions any-nix-shell
    # Utils
    fzf sysz ripgrep fd bat exa sd dogdns rm-improved ouch jq
    xh gh rbw hyperfine hexyl choose tokei git delta zellij rsync
    # System info
    ncdu duf du-dust htop lm_sensors bottom bandwhich usbtop procs powertop
    # Language tools
    shfmt shellcheck stylua sumneko-lua-language-server black pyright
    taplo rust-analyzer clang-tools_14 nil
    # Toolchain
    sccache ccache python3 mold bear rustup lldb
    # Cargo
    cargo-edit cargo-expand cargo-outdated cargo-udeps cargo-watch
    cargo-bloat cargo-flamegraph cargo-clone cargo-play
    # Nix
    nix nix-output-monitor nix-tree nix-direnv
  ] ++ (with llvmPackages_14; [ (lib.lowPrio clang) lld ]);

  imports = [ ./vim.nix ];

  nixpkgs.overlays = [ (final: prev: {
    fzf = prev.fzf.overrideAttrs ( prev: { # patch out perl dep
      postInstall = prev.postInstall + ''
        rm $out/share/fzf/key-bindings.bash
      '';
    });
  })];

  # Use a locale-archive without the full 200MB of locales
  systemd.user.sessionVariables = {
    LOCALE_ARCHIVE_2_27 = lib.mkForce "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive";
  };
}
