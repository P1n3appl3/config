{ config, pkgs, ... }: {
  home.username = "joseph";
  home.homeDirectory = "/home/joseph";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  home.sessionVariables = {};
  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions
    # Utils
    fzf sysz ripgrep fd bat exa sd dog rm-improved ouch jq
    xh gh rbw hyperfine hexyl choose tokei git delta zellij rsync
    # System info
    ncdu duf du-dust htop lm_sensors bottom bandwhich usbtop procs powertop
    # Language tools
    shfmt shellcheck stylua sumneko-lua-language-server
    taplo rust-analyzer black pyright nil
    # Toolchain
    rustup sccache ccache python3 mold lld bear gdb clang clang-tools llvm lldb
    # Cargo
    cargo-edit cargo-expand cargo-outdated cargo-udeps cargo-watch
    cargo-bloat cargo-flamegraph cargo-clone cargo-play
    # Nix
    nix-output-monitor nix-tree
  ];

  imports = [ ./vim.nix ];

  nixpkgs.overlays = [ (final: prev: {
    fzf = prev.fzf.overrideAttrs ( prev: { # patch out perl dep
      postInstall = prev.postInstall + ''
        rm $out/share/fzf/key-bindings.bash
      '';
    });
  })];
}
