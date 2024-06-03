{ pkgs, ... }: {
  imports = [
    ./hardware.nix
  ];

  home-manager.users.julia.imports = [
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

  environment.systemPackages = with pkgs; [
    littlefs-fuse
    google-chrome
    unrar-free
  ];

  programs = {
    dconf.enable = true;
    steam.enable = true;
    appimage = { enable = true; binfmt = true; };
  };

  services = {
    flatpak.enable = true;
    pipewire = { enable = true;
      wireplumber.enable = true; alsa.enable = true;
      pulse.enable = true; jack.enable = true;
    };
    automatic-timezoned.enable = true;
    # I don't use xorg, so these are just for the tty
    # TODO: set these some other way, either console.keymap or interceptor
    xserver.xkb.options = "altwin:swap_alt_win,caps:escape,shift:both_capslock";
    upower.enable = true;
  };

  # only needed for flatpak, home-manager controls wlr/gtk portals for sway
  # and this is maybe possible to dedup with the home-manager settings
  xdg.portal = { enable = true; wlr.enable = true; config.common.default = "*"; };

  networking = { hostName = "WOPR"; networkmanager.enable = true; };

  security.pam.services.swaylock = {};
}
