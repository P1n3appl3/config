{ pkgs, inputs, lib, config, myOverlays, ... } @ args: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    ./nvim.nix
    (if builtins.hasAttr "osConfig" args then {} else
      { nixpkgs = { overlays = myOverlays; config.allowUnfree = true; }; })
  ];

  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions nix-zsh-completions
    # Utils
    fzf ripgrep fd bat eza sd dogdns ouch jq xh rbw hyperfine hexyl choose
    tokei zellij rsync zstd lowcharts trippy page pv datamash ascii numbat
    pinentry sshping sshx
    # System info
    htop bottom bandwhich trippy procs smartmontools duf ncdu du-dust
    # Git
    git git-lfs delta gh git-heatmap git-absorb lazygit
    # Nix
    nix home-manager nix-output-monitor nix-tree nil comma
    # Scripting tools
    stylua sumneko-lua-language-server shfmt shellcheck mawk
    # Fun
    blahaj gay lolcat fortune cowsay neo tmatrix sl pipes ascii-rain
  ];

  programs = {
    direnv = { enable = true; nix-direnv.enable = true; };
  };

  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
    config.to = { type = "git"; url = "file://" + config.home.sessionVariables.CONF_DIR; };
  };

  home = {
    username = lib.mkDefault "joseph";
    homeDirectory = lib.mkDefault "/home/joseph";
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
      }) (lib.filesystem.listFilesRecursive ../dotfiles));
  };
}
