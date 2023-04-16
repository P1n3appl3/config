{ pkgs, inputs, lib, ... }: {
  home.username = "joseph";
  home.homeDirectory = "/home/joseph";
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Shell
    atuin starship zoxide zsh-syntax-highlighting zsh-autosuggestions
    direnv nix-zsh-completions any-nix-shell
    # Utils
    fzf sysz ripgrep fd bat exa sd dogdns rm-improved ouch jq
    xh gh rbw hyperfine hexyl choose tokei git delta zellij rsync
    git-heatmap
    # System info
    ncdu duf du-dust htop lm_sensors bottom bandwhich usbtop procs powertop
    # Language tools
    shfmt shellcheck stylua sumneko-lua-language-server black pyright
    taplo rust-analyzer clang-tools_14 nil bloaty
    # Toolchain
    sccache ccache python3 mold bear rustup lldb
    # Cargo
    cargo-edit cargo-expand cargo-outdated cargo-udeps cargo-watch
    cargo-bloat cargo-flamegraph cargo-clone cargo-play
    # Nix
    nix nix-output-monitor nix-tree nix-direnv
  ] ++ (with llvmPackages_14; [ (lib.lowPrio clang) lld ]);

  imports = [
    ./vim.nix

    (let # use a minimal locale-archive without the full 200MB of locales
      a = lib.mkForce "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive";
    in {
      systemd.user.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
      home.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
    })
  ];

  nixpkgs.overlays = [ (final: prev: {
    # patch out perl dep
    fzf = prev.fzf.overrideAttrs ( prev: { 
      postInstall = prev.postInstall + "rm $out/share/fzf/key-bindings.bash";
    });

    # # example of doing the same patch but with a wrapper to avoid rebuilding
    # fzf = final.stdenvNoCC.mkDerivation {
    #   inherit (prev.fzf) pname version outputs meta;
    #   dontUnpack = true; dontConfigure = true; dontBuild = true;
    #   installPhase = map (o: ''cp -r ${prev.fzf.${o}} ''$${o};'') prev.fzf.outputs;
    #   fixupPhase = "chmod +w -R $out; rm $out/share/fzf/key-bindings.bash";
    # };
  })];

  # use the nixpkgs version from this flake for my nixpkgs channel (for things
  # like `nix-shell`) and registry (for things like `nix shell`)
  home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs.outPath}";
  nix.registry.nixpkgs.flake = inputs.nixpkgs;
}
