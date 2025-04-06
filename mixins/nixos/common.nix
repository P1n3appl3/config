{ pkgs, lib, inputs, config, myOverlays, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.ragenix.nixosModules.default
    inputs.catppuccin.nixosModules.catppuccin
    ./friends.nix
  ];

  users.users.julia = {
    isNormalUser = true;
    extraGroups = [ "julia" "wheel" ];
    initialPassword = "changethis";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCatP3klEjfQPSiJNUc3FRDdz927BG1IzektpouzOZR"
    ];
    linger = true;
  };
  users.defaultUserShell = pkgs.zsh;

  programs = {
    zsh = { enable = true; enableCompletion = false; };
    command-not-found.enable = false;
    bandwhich.enable = true;
    trippy.enable = true;
  };

  services = {
    atd.enable = true;
    nixseparatedebuginfod.enable = true;
    getty = {
      autologinUser = "julia";
      greetingLine = ''\l'';
      helpLine = lib.mkForce "♥";
    };
  };

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    at
    file
    zip unzip
    psmisc
    usbutils
    uhubctl
    config.boot.kernelPackages.perf
    kitty.terminfo
    cntr
  ];

  age = {
    ageBin = lib.getExe pkgs.rage;
    identityPaths = [ "/home/julia/.ssh/id_ed25519" ];
  };
  home-manager.useGlobalPkgs = true;
  security.sudo.extraConfig = ''Defaults env_keep += "path"'';
  catppuccin = { enable = true; flavor = "mocha"; };
  console.useXkbConfig = true;
  nixpkgs = { overlays = myOverlays; config.allowUnfree = true; };
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      extra-experimental-features = [ "nix-command" "flakes" ];
    };
    registry.config.to = { type = "git";
      url = "file://" + config.home-manager.users.julia.home.sessionVariables.CONF_DIR;
    };
  };
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  system.stateVersion = "24.05";
}
