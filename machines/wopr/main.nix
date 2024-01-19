{ pkgs, inputs, myOverlays, ... }: {
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  environment.systemPackages = with pkgs; [
    framework-tool
    amdgpu_top
    clang
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
    # TODO: helpLine replace instead of merging
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
      ../../mixins/home-manager/common.nix
      ../../mixins/home-manager/linux.nix
      ../../mixins/home-manager/btrfs.nix
      ../../mixins/home-manager/dev.nix
      ../../mixins/home-manager/graphical/common.nix
      ../../mixins/home-manager/graphical/hyprland.nix
      ../../mixins/home-manager/graphical/music.nix
      ../../mixins/home-manager/graphical/games.nix
    ];
  };

  # TODO: put in games module dependent on osConfig
  programs.steam.enable = true;

  networking = { hostName = "WOPR"; networkmanager.enable = true; };
}
