{pkgs, inputs, lib, config, myOverlays, ...}: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users.users.joseph = {
    isNormalUser = true;
    extraGroups = [ "joseph" "wheel" ];
    initialPassword = "changethis";
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfVoCjrBTOH746bJCKQwRgWzjFskNeLQKz73qmd4P3tmiJIFMAim7MiCwtQbxvIUOTZHbG7vRHZ5SwSH/d/wqmESmY1meRH/43uP4YlRRwUFkUHcwEJsVP9dDza0jYuBXVo04B/fuP93W2+aeBPKiSuWrnQ9s2LwRJ/0aqani8xpVn87EXp90aXjdF4iqu7tL4Nn1zUULYOdULrry0j6moUumUhmtkWb0PrTcxZr7BoDz8UH7Fu9G0uK8Xr5dAxs7RgTyFpUWg6h+AKQczMHLluwuRr2m12gWXKZIVO+Sw1PYYuU58Y7+E00KEM1Xy9SnuOW5ZgnxWBqydD+Gc2q67"];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    zsh.enableCompletion = false;
    command-not-found.enable = false;
  };

  home-manager = { useGlobalPkgs = true; useUserPackages = true; };
  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    at
    file
    psmisc
    config.boot.kernelPackages.perf
    kitty.terminfo
  ];

  security.sudo.extraConfig = ''Defaults env_keep += "path"'';
  console.useXkbConfig = true;
  nixpkgs = { overlays = myOverlays; config.allowUnfree = true; };
  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.extraOptions = "experimental-features = nix-command flakes";
  time.timeZone = lib.mkDefault "America/Los_Angeles";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  system.stateVersion = "23.05";
}
