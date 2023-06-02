{ pkgs, inputs, lib, ... }: {
  home.username = "joseph";
  home.homeDirectory = "/home/joseph";
  home.stateVersion = "22.11";
  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions
    direnv nix-zsh-completions nix-your-shell
    # Git
    git delta gh git-heatmap git-absorb lazygit
    # Utils
    fzf sysz ripgrep fd bat exa sd dogdns rm-improved ouch jq
    xh rbw hyperfine hexyl choose tokei zellij rsync lowcharts 
    zstd util-linux trippy asciinema page
    # System info
    htop lm_sensors bottom bandwhich usbtop procs powertop
    # Storage
    smartmontools btrfs-progs compsize duperemove btdu duf ncdu du-dust
    # Language tools
    nil bloaty taplo bear mold ruff black pyright
    shfmt shellcheck stylua sumneko-lua-language-server
    # Rust
    rustup sccache (lib.lowPrio measureme) cargo-edit cargo-expand
    cargo-udeps cargo-watch cargo-clone-crate cargo-play cargo-bloat
    # Nix
    nix home-manager nix-output-monitor nix-tree nix-direnv cachix
    # Fun
    blahaj gay lolcat fortune cowsay neo tmatrix ascii-rain sl pipes tty-clock
  ];

  nixpkgs.overlays = [ (final: prev: {
    fzf = prev.fzf.overrideAttrs ( self: { # TODO: remove once perl is gone
      postInstall = self.postInstall + "rm $out/share/fzf/key-bindings.bash";
    });
  })];

  programs.neovim = {
    enable = true; viAlias = true; vimAlias = true;
    withPython3 = true; withRuby = false;
    plugins = with pkgs.vimPlugins; [ lazy-nvim
      # these plugins have native deps, so they're managed by nix
      (nvim-treesitter.withPlugins (p: with p; [
        bash c cpp python rust lua zig kdl json toml json json5 
        make ninja dot nix latex html css typescript javascript
      ]))
      nvim-treesitter-textobjects nvim-treesitter-context
      coq_nvim coq-artifacts
    ];
  };

  imports = [
    (let # use a minimal locale-archive without the full 200MB of locales
      a = lib.mkForce "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive";
    in {
      systemd.user.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
      home.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
    })
  ];

  # use the nixpkgs version from this flake for my nixpkgs channel (for things
  # like `nix-shell`) and registry (for things like `nix shell`)
  home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs.outPath}";
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  targets.genericLinux.enable = true;
}
