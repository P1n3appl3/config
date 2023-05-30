{ pkgs, inputs, lib, ... }: {
  home.username = "joseph";
  home.homeDirectory = "/home/joseph";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions
    direnv nix-zsh-completions nix-your-shell
    # Utils
    fzf sysz ripgrep fd bat exa sd dogdns rm-improved ouch jq
    xh gh rbw hyperfine hexyl choose tokei git delta zellij rsync
    barchart git-heatmap git-absorb lowcharts so zstd util-linux
    trippy asciinema
    # TODO: git frontend like tig/gitui/lazygit
    # System info
    htop lm_sensors bottom bandwhich usbtop procs powertop
    # Storage
    smartmontools btrfs-progs compsize duperemove btdu duf ncdu du-dust
    # Language tools
    nil bloaty taplo bear mold ruff black pyright
    shfmt shellcheck stylua sumneko-lua-language-server
    # Rust
    rustup sccache (lib.lowPrio measureme)
    cargo-edit cargo-expand cargo-udeps cargo-watch cargo-clone-crate
    cargo-play cargo-bloat cargo-llvm-lines
    # Nix
    nix home-manager nix-output-monitor nix-tree nix-direnv cachix
    # Fun
    blahaj gay (lib.lowPrio lolcat) lolcat-rust lolcrab dotacat fortune cowsay
    globe-cli neo tmatrix ascii-rain sl pipes tty-clock
  ];

  imports = [
    (let # use a minimal locale-archive without the full 200MB of locales
      a = lib.mkForce "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive";
    in {
      systemd.user.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
      home.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
    })
  ];

  nixpkgs.overlays = [ (final: prev: {
    # TODO: remove if https://github.com/junegunn/fzf/pull/3295 lands
    fzf = prev.fzf.overrideAttrs ( self: { # patch out perl dep
      postInstall = self.postInstall + "rm $out/share/fzf/key-bindings.bash";
    });
  })];

  programs.neovim = {
    enable = true; viAlias = true; vimAlias = true;
    withPython3 = true; withRuby = false;
    plugins = with pkgs.vimPlugins; [ lazy-nvim ];
  };

  # use the nixpkgs version from this flake for my nixpkgs channel (for things
  # like `nix-shell`) and registry (for things like `nix shell`)
  home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs.outPath}";
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  targets.genericLinux.enable = true;
}
