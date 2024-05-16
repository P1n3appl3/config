{ pkgs, lib, inputs, myOverlays, ... }: {
  imports = [
    ./hardware.nix
  ];

  environment.systemPackages = with pkgs; [
    clang
    littlefs-fuse
    google-chrome
    unrar-free
  ];

  programs = {
    dconf.enable = true;
    # TODO: put in games module dependent on osConfig
    steam.enable = true;
  };

  services = {
    pipewire = { enable = true;
      wireplumber.enable = true; alsa.enable = true;
      pulse.enable = true; jack.enable = true;
    };
    automatic-timezoned.enable = true;
    getty = {
      autologinUser = "julia";
      greetingLine = ''\l'';
      helpLine = lib.mkForce "♥";
    };
    # I don't use xorg, so these are just for the tty
    # TODO: set these some other way? either console.keymap or interceptor
    xserver.xkb.options = "altwin:swap_alt_win,caps:escape,shift:both_capslock";
    upower.enable = true;
  };

  networking = { hostName = "WOPR"; networkmanager.enable = true; };

  security.pam.services.swaylock = {};

  home-manager = {
    extraSpecialArgs = { inherit inputs myOverlays; };
    users.julia.imports = [
      { programs.kitty.settings.font_size = 15; }
      ../../mixins/home/common.nix
      ../../mixins/home/linux.nix
      ../../mixins/home/btrfs.nix
      ../../mixins/home/dev.nix
      ../../mixins/home/graphical/common.nix
      ../../mixins/home/graphical/sway.nix
      ../../mixins/home/graphical/music.nix
      ../../mixins/home/graphical/games.nix
      ../../mixins/home/graphical/media.nix
    ];
  };
}
