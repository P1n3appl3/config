{ pkgs, inputs, myOverlays, ... }: {
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  services = {
    pipewire = {
      enable = true; wireplumber.enable = true;
      alsa.enable = true; pulse.enable = true; jack.enable = true;
    };
    localtimed.enable = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs myOverlays; };
    users.joseph.imports = [
      ../../home-modules/common.nix
      ../../home-modules/linux.nix
      ../../home-modules/btrfs.nix
      ../../home-modules/dev.nix
      ../../home-modules/graphical/common.nix
      ../../home-modules/graphical/hyprland.nix
      ../../home-modules/graphical/music.nix
      { home.keyboard.options = [ "altwin:swap_alt_win" ]; }
    ];
  };

  # xdg.portal = { enable = true;
  #   config = TODO
  # }
  # TODO: remove when obsidian updates
  # TODO: why do i have to mirror the home-manager config here?
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  environment.systemPackages = with pkgs; [
    framework-tool
    firmware-updater firmware-manager # TODO: pick one
  ];

  services.getty.autologinUser = "joseph";
  networking = { hostName = "WOPR"; networkmanager.enable = true; };
}
