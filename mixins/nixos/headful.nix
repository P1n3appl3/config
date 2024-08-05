{ pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    google-chrome
    glib
    unrar-free
  ];

  programs.dconf.enable = true;

  services = {
    pipewire = { enable = true;
      wireplumber.enable = true; alsa.enable = true;
      pulse.enable = true; jack.enable = true;
    };
    # I don't use xorg, so these are just for the tty
    # TODO: set these some other way, either console.keymap or interceptor
    xserver.xkb.options = "altwin:swap_alt_win,caps:escape,shift:both_capslock";
  };

  # only needed for flatpak, home-manager controls wlr/gtk portals for sway
  # and this is maybe possible to dedup with the home-manager settings
  xdg.portal = { enable = true; wlr.enable = true; config.common.default = "*"; };

  security.pam.services.swaylock = {};
}
