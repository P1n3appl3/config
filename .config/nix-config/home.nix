{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions
    direnv nix-zsh-completions
    # Utils
    fzf ripgrep fd bat exa sd dogdns rm-improved ouch jq xh rbw hyperfine
    hexyl choose tokei zellij rsync zstd lowcharts trippy asciinema page pv
    # System info
    htop bottom bandwhich procs smartmontools duf ncdu du-dust
    # Git
    git delta gh git-heatmap git-absorb lazygit
    # Nix
    nix home-manager nix-output-monitor nix-tree nix-direnv cachix nil
    # Scripting tools
    stylua sumneko-lua-language-server shfmt shellcheck
    # Fun
    blahaj gay lolcat fortune cowsay neo tmatrix sl pipes ascii-rain
  ];

  imports = [ ./home-modules/nvim.nix ];

  nixpkgs.overlays = [ (final: prev: {
    fzf = prev.fzf.overrideAttrs ( self: { # TODO: remove once perl is gone
      postInstall = self.postInstall + "rm $out/share/fzf/key-bindings.bash";
    });
  })];

  # use the nixpkgs version from this flake for my nixpkgs channel (for things
  # like `nix-shell`) and registry (for things like `nix shell`)
  home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs.outPath}";
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  home.stateVersion = "22.11";
}
