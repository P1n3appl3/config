{ pkgs, inputs, lib, config, myOverlays, ... }: {
  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions nix-zsh-completions
    # Utils
    fzf ripgrep fd bat eza sd dogdns rm-improved ouch jq xh rbw hyperfine
    hexyl choose tokei zellij rsync zstd lowcharts trippy asciinema page pv
    datamash ascii
    # System info
    htop bottom bandwhich procs smartmontools duf ncdu du-dust
    # Git
    git delta gh git-heatmap git-absorb lazygit
    # Nix
    # TODO: nom FE0E -> FE0F for emojis
    nix home-manager nix-output-monitor nix-tree cachix nil comma hydra-check
    # Scripting tools
    stylua sumneko-lua-language-server shfmt shellcheck
    # Fun
    blahaj gay lolcat fortune cowsay neo tmatrix sl pipes ascii-rain
  ];

  programs = {
    direnv = { enable = true; nix-direnv.enable = true; };
  };

  imports = [
    { nixpkgs.overlays = myOverlays; }
    inputs.nix-index-database.hmModules.nix-index
    ./nvim.nix
  ];

  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
    # TODO: can i refer to "self" somehow as a flake?
    # config.to = config.home.sessionVariables.CONF_DIR;
  };

  home = {
    username = lib.mkDefault "joseph";
    homeDirectory = lib.mkDefault "/home/joseph";
    stateVersion = "23.05";
    sessionVariables = {
      NIX_PATH = "nixpkgs=${inputs.nixpkgs.outPath}";
      CONF_DIR = lib.mkDefault (config.home.homeDirectory + "/config");
    };

    activation.symlinkDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
      _conf_dir=${config.home.sessionVariables.CONF_DIR}
      echo conf dir $_conf_dir
      $DRY_RUN_CMD shopt -s dotglob
      for f in $_conf_dir/dotfiles/**/*; do
        if [ -f "$f" ]; then
          f=$(realpath --relative-to $_conf_dir/dotfiles $f)
          echo haha $f
          $DRY_RUN_CMD mkdir -p $VERBOSE_ARG $HOME/$(dirname $f)
          $DRY_RUN_CMD ln -sf $VERBOSE_ARG $_conf_dir/dotfiles/$f $HOME/$f
        fi
      done
      $DRY_RUN_CMD shopt -u dotglob
    '';
  };
}
