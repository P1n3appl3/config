{ pkgs, ...}: {

  environment.systemPackages = with pkgs; [
    google-chrome
    glib
    unrar-free
    jmtpfs
    adwaita-icon-theme # seems to fix gsettings schema bug for some reason
  ];

  programs.dconf.enable = true;

  services = {
    mullvad-vpn = { enable = true; package = pkgs.mullvad-vpn; };
    udisks2 = { enable = true; mountOnMedia = true; };
    pipewire = { enable = true;
      wireplumber.enable = true; alsa.enable = true; pulse.enable = true;
      jack.enable = false; # enable as needed
    };
    # I don't use xorg everywhere, so sometimes these are just for the tty
    # TODO: set these some other way, either console.keymap or interceptor
    xserver.xkb.options = "altwin:swap_alt_win,caps:escape,shift:both_capslock";
  };

  # only needed for flatpak, home-manager controls wlr/gtk portals for sway
  # and this is maybe possible to dedup with the home-manager settings
  xdg.portal = { enable = true; wlr.enable = true; config.common.default = "*"; };

  users.users.julia.extraGroups = [ "dialout" "netdev" ];
}
