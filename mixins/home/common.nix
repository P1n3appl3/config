{ pkgs, inputs, lib, config, myOverlays, ... } @ args: {
  home.packages = with pkgs; [
    # Utils
    fzf ripgrep fd eza sd doggo ouch xh dl rbw pinentry-curses hyperfine heh
    tokei zellij zeco rsync zstd pv sshping mdcat magic-wormhole-rs rage
    exiftool resvg get-keys vivid pipe-rename static-web-server cached-path
    ascii unicode-paracode sequin tty-share bore-cli scooter micro chafa
    # Munge
    jq pup choose datamash numbat lowcharts d-rs mawk csvlens fx # xan tabiew
    # System info
    btop procs smartmontools duf ncdu dust
    # Nix
    nix home-manager nh nix-output-monitor nix-tree nix-diff nil comma ragenix
    # Scripting tools
    stylua lua-language-server shfmt shellcheck fish-lsp
    # Fun
    blahaj gay lolcat fortune cowsay neo tmatrix sl pipes ascii-rain pastel tab
    ttyper solitaire-tui nethack
  ];

  programs = {
    helix = { enable = true; settings = lib.mkForce {}; };
    bat = { enable = true; };
    direnv = { enable = true;
      nix-direnv.enable = true;
      config.global.hide_env_diff = true;
    };
    ssh = { enable = true;
      includes = [ "extra-config" ];
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          serverAliveInterval = 30;
          controlPersist = "15h";
          controlMaster = "auto";
          compression = true;
        };
        "pineapple.computer julia.blue Cortana" = {
          hostname = "%h"; user = "julia"; port = 69;
        };
      };
    };
  };

  imports = [
    ./git.nix ./nvim.nix ./htop.nix ./shells.nix
    (if builtins.hasAttr "osConfig" args then {} else
      { nixpkgs = { overlays = myOverlays; config.allowUnfree = true; }; })
    inputs.nix-index-database.homeModules.nix-index
    inputs.ragenix.homeManagerModules.default
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    flavor = "mocha"; accent = "blue";
    bat.enable = true; cava.enable = true; helix.enable = true; btop.enable = true;
    fish.enable = true; zellij.enable = true; fzf.enable = true;
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
    stateVersion = "25.11";
    preferXdgDirectories = true;

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
