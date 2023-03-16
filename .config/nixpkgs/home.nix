{ config, pkgs, ... }: {
  home.username = "joseph";
  home.homeDirectory = "/home/joseph";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
  home.sessionVariables = {};
  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide direnv zsh-syntax-highlighting zsh-autosuggestions
    # Utils
    fzf sysz ripgrep fd bat exa sd dogdns rm-improved ouch jq
    xh gh rbw hyperfine hexyl choose tokei git delta zellij rsync
    # System info
    ncdu duf du-dust htop lm_sensors bottom bandwhich usbtop procs powertop
    # Language tools
    shfmt shellcheck stylua sumneko-lua-language-server black pyright
    taplo rust-analyzer clang-tools nil
    # Toolchain
    sccache ccache python3 mold bear rustup # gdb lldb
    # Cargo
    cargo-edit cargo-expand cargo-outdated cargo-udeps cargo-watch
    cargo-bloat cargo-flamegraph cargo-clone cargo-play
    # Nix
    nix nix-output-monitor nix-tree nix-direnv
  ]; # ++ (with llvmPackages; [ (lib.hiPrio clang-unwrapped) bintools ]);

  imports = [ ./vim.nix ];

  nixpkgs.overlays = [ (final: prev: {
    fzf = prev.fzf.overrideAttrs ( prev: { # patch out perl dep
      postInstall = prev.postInstall + ''
        rm $out/share/fzf/key-bindings.bash
      '';
    });
  })];
}
