{pkgs, inputs, config, myOverlays, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./friends.nix
  ];

  users.users.julia = {
    isNormalUser = true;
    extraGroups = [ "julia" "wheel" ];
    initialPassword = "changethis";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCatP3klEjfQPSiJNUc3FRDdz927BG1IzektpouzOZR"
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  programs = {
    zsh.enable = true;
    zsh.enableCompletion = false;
    command-not-found.enable = false;
  };

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    at
    file
    zip unzip
    psmisc
    usbutils
    config.boot.kernelPackages.perf
    kitty.terminfo
  ];

  security.sudo.extraConfig = ''Defaults env_keep += "path"'';
  console.useXkbConfig = true;
  home-manager.useGlobalPkgs = true;
  nixpkgs = { overlays = myOverlays; config.allowUnfree = true; };
  nix = {
    settings.trusted-users = [ "root" "@wheel" ];
    extraOptions = "experimental-features = nix-command flakes";
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      # TODO: dedup to a shared nixos/home module
      config.to = { type = "git"; url = "file:///home/julia/config"; };
    };
  };
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  system.stateVersion = "23.11";
}
