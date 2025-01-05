{ pkgs, inputs, lib, config, myOverlays, ... } @ args: {
  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions nix-zsh-completions
    # Utils
    fzf ripgrep fd eza sd dogdns ouch xh dl rbw pinentry-curses hyperfine heh
    tokei zellij rsync zstd pv sshping mdcat magic-wormhole-rs netscanner rage
    exiftool resvg get-keys vivid pipe-rename static-web-server
    ascii unicode-paracode sequin pastel
    micro helix
    # Munge
    jq pup choose datamash numbat lowcharts d-rs mawk csvlens
    # System info
    btop procs smartmontools duf ncdu du-dust
    # Nix
    nix home-manager nh nix-output-monitor nix-tree nil comma ragenix
    # Scripting tools
    stylua sumneko-lua-language-server shfmt shellcheck
    # Fun
    blahaj gay lolcat fortune cowsay neo tmatrix sl pipes ascii-rain pastel tab
    ttyper nethack
  ];

  programs = {
    bat = { enable = true; };
    direnv = { enable = true;
      nix-direnv.enable = true;
      config.global.hide_env_diff = true;
    };
  };

  imports = [
    ./git.nix ./nvim.nix ./htop.nix ./bash.nix
    (if builtins.hasAttr "osConfig" args then {} else
      { nixpkgs = { overlays = myOverlays; config.allowUnfree = true; }; })
    inputs.nix-index-database.hmModules.nix-index
    inputs.ragenix.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin = {
    flavor = "mocha"; accent = "blue";
    bat.enable = true; cava.enable = true; helix.enable = true; btop.enable = true;
    # TODO: fzf/zellij/zsh-syntax-highlighting
  };

  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
    config.to = { type = "git"; url = "file://" + config.home.sessionVariables.CONF_DIR; };
  };

  systemd.user.startServices = "sd-switch"; # start/stop services to match config
  age = {
    package = pkgs.rage;
    secrets.nix-conf = {
      file = ../../secrets/nix-conf.age;
      path = "${config.home.homeDirectory}/.config/nix/extra.conf";
    };
  };

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
