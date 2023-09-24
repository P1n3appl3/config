{ pkgs, inputs, lib, myOverlays, ... }: {
  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions
    direnv nix-zsh-completions
    # Utils
    fzf ripgrep fd bat eza sd dogdns rm-improved ouch jq xh rbw hyperfine
    hexyl choose tokei zellij rsync zstd lowcharts trippy asciinema page pv
    datamash ascii
    # System info
    htop bottom bandwhich procs smartmontools duf ncdu du-dust
    # Git
    git delta gh git-heatmap git-absorb lazygit
    # Nix
    nix home-manager nix-output-monitor nix-tree nix-direnv cachix nil comma
    # Scripting tools
    stylua sumneko-lua-language-server shfmt shellcheck
    # Fun
    blahaj gay lolcat fortune cowsay neo tmatrix sl pipes ascii-rain
  ];

  imports = [
    { nixpkgs.overlays = myOverlays; }
    inputs.nix-index-database.hmModules.nix-index
    ./nvim.nix
  ];

  home = {
    username = lib.mkDefault "joseph";
    homeDirectory = lib.mkDefault "/home/joseph";
    stateVersion = "23.05";

    # use the nixpkgs version from this flake for my nixpkgs channel
    sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs.outPath}";
  };
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
