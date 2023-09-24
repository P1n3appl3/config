{pkgs, inputs, myOverlays, ...}: {
  imports = [
    { nixpkgs.overlays = myOverlays; }
    # TODO: figure out how it's possible that `nixfind rpi-eeprom-config`
    # works in home-manager but not NixOS... shouldn't they both be using the
    # exact same nixpkgs from the flake input? i don't have channels enabled in
    # NixOS by accident or something right? maybe it's because I have both the
    # home-manager module AND nixos module for nix-index-database enabled at the
    # same time. if that's the case I could try conditioning the import of the
    # home-manager module on NOT having a nixos config available which I think
    # is possible since hm modules can take a nixos config as an argument.
    inputs.nix-index-database.nixosModules.nix-index
    inputs.home-manager.nixosModules.home-manager
  ];

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

  nix.settings = {
    trusted-users = [ "root" "@wheel" ];
    # substituters = [ "https://cache.garnix.io" "https://pineapple.cachix.org" ];
    # trusted-public-keys = [
    #   "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    #   "pineapple.cachix.org-1:FjFjdb26PFCZL09M2yHiPw1J+c1Ab9AbpfnFeTpzNQk="
    # ];
  };
  nix.extraOptions = "experimental-features = nix-command flakes";
  time.timeZone = "America/Los_Angeles";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];
  system.stateVersion = "23.05";

  # TODO: why does `nom` not textwrap correctly when using sudo? prob more
  # sudo-environment related than terminfo
  security.sudo.extraConfig = ''Defaults env_keep += "path"'';
  environment.systemPackages = with pkgs; [ at file psmisc kitty.terminfo ];
}
