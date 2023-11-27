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
    # TODO: sleep states, suspend to ram, hibernate, lid close and idle timeout
    # upower = { enable = true; criticalPowerAction = "Hibernate"; };
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
      # TODO: check if this works in hyprland
      { home.keyboard.options = [ "altwin:swap_alt_win" ]; }
    ];
  };

  environment.systemPackages = with pkgs; [
    framework-tool
  ];

  services.getty.autologinUser = "joseph"; # TODO: exec hyprland in login sequence
  networking.hostName = "WOPR";
}
