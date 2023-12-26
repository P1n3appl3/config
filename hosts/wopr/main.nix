{ pkgs, inputs, myOverlays, ... }: {
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  environment.systemPackages = with pkgs; [
    framework-tool
    amdgpu_top
  ];

  programs = {
    hyprland.enable = true;
  };

  services = {
    pipewire = {
      enable = true; wireplumber.enable = true;
      alsa.enable = true; pulse.enable = true; jack.enable = true;
    };
    automatic-timezoned.enable = true;
    # TODO: get rid of the help line too
    getty = { autologinUser = "joseph"; greetingLine = ''\l''; helpLine = "owo"; };
    # I don't use xorg, so these are just for the tty
    # TODO: set these some other way? either console.keymap or interceptor
    xserver.xkb.options = "altwin:swap_alt_win,caps:escape,shift:both_capslock";
    upower.enable = true;
  };

  # TODO: remove when obsidian updates
  # TODO: why do i have to mirror the home-manager config here?
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

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
    ];
  };

  networking = { hostName = "WOPR"; networkmanager.enable = true; };
}
