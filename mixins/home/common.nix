{ pkgs, inputs, lib, config, myOverlays, ... } @ args: {
  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions nix-zsh-completions
    # Utils
    fzf ripgrep fd bat eza sd dogdns ouch jq xh rbw hyperfine hexyl choose
    tokei zellij rsync zstd lowcharts trippy page pv datamash ascii numbat
    pinentry sshping mdcat magic-wormhole-rs netscanner
    # System info
    bottom bandwhich trippy procs smartmontools duf ncdu du-dust
    # Git
    git git-lfs delta gh git-heatmap git-absorb lazygit
    # Nix
    nix home-manager nh nix-output-monitor nix-tree nil comma
    # Scripting tools
    stylua sumneko-lua-language-server shfmt shellcheck mawk
    # Fun
    blahaj gay lolcat fortune cowsay neo tmatrix sl pipes ascii-rain
  ];

  programs = {
    direnv = { enable = true; nix-direnv.enable = true; config.global.hide_env_diff = true; };
  };

  imports = [
    ./nvim.nix
    ./htop.nix
    (if builtins.hasAttr "osConfig" args then {} else
      { nixpkgs = { overlays = myOverlays; config.allowUnfree = true; }; })
    inputs.nix-index-database.hmModules.nix-index
  ];

  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
    config.to = { type = "git"; url = "file://" + config.home.sessionVariables.CONF_DIR; };
  };

  systemd.user.startServices = "sd-switch"; # start/stop services to match config

  home = {
    username = lib.mkDefault "julia";
    homeDirectory = lib.mkDefault "/home/julia";
    stateVersion = "23.11";

    sessionVariables = {
      NIX_PATH = "nixpkgs=flake:nixpkgs";
      CONF_DIR = lib.mkDefault (config.home.homeDirectory + "/config");
    };

    file = builtins.listToAttrs (map (path:
      let f = lib.strings.removePrefix (inputs.self + "/dotfiles/") (toString path);
      in {
        name = f ; value = {source = config.lib.file.mkOutOfStoreSymlink
          (config.home.sessionVariables.CONF_DIR + "/dotfiles/" + f);};
      }) (lib.filesystem.listFilesRecursive ../../dotfiles));
  };
}
