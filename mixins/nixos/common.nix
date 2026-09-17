{ pkgs, lib, inputs, config, self, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.ragenix.nixosModules.default
    inputs.catppuccin.nixosModules.catppuccin
    ./friends.nix
  ];

  users.users.julia = {
    isNormalUser = true; uid = 1337;
    extraGroups = [ "julia" "wheel" ];
    initialPassword = "changethis";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPCatP3klEjfQPSiJNUc3FRDdz927BG1IzektpouzOZR"
    ];
    linger = true;
  };
  users.defaultUserShell = pkgs.fish;

  programs = {
    fish = { enable = true; useBabelfish = true; };
    zsh.enable = true;
    command-not-found.enable = false;
    bandwhich.enable = true;
    trippy.enable = true;
  };

  services = {
    atd.enable = true;
    nixseparatedebuginfod2.enable = true;
    avahi.enable = true;
    # angrr = { enable = true; timer.enable = true; };
    getty = {
      autologinUser = "julia";
      greetingLine = ''\l'';
      helpLine = lib.mkForce "♥";
    };
  };

  environment.systemPackages = with pkgs; [
    at
    file
    zip unzip
    psmisc
    usbutils
    uhubctl
    perf
    kitty.terminfo kitty.kitten
    cntr
  ] ++ config.home-manager.users.julia.home.packages;

  
  networking = {
    firewall = {
      allowedTCPPorts = [
        8000 8080
      ];
    };
    dhcpcd.extraConfig = "slaac hwaddr"; # fixed ipv6 address
  };

  boot = {
    extraModulePackages = [ pkgs.uwurandom ];
    kernelModules = [ "uwurandom" ];
    loader = {
      systemd-boot = lib.mkDefault { enable = true;
        configurationLimit = 5;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  age = {
    ageBin = lib.getExe pkgs.rage;
    identityPaths = [ "/home/julia/.ssh/id_ed25519" ];
  };
  home-manager.useGlobalPkgs = true;
  security = {
    sudo.extraConfig = ''Defaults env_keep += "path"'';
    polkit.enable = true;
  };
  catppuccin = { enable = true; autoEnable = true; flavor = "mocha"; };
  console.useXkbConfig = true;
  nixpkgs = {
    overlays = [ self.overlays.default ];
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "x86_64-linux";
  };
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
  system = {
    stateVersion = "25.11";
    nixos.distroName = "gay linux";
  };
}
