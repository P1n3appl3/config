{ pkgs, lib, ...}: {

  environment.systemPackages = with pkgs; [
    google-chrome
    glib
    unrar-free
    adwaita-icon-theme # seems to fix gsettings schema bug for some reason
    gparted
    qpwgraph
    via vial
    piper
    wireshark
  ];

  programs = {
    dconf.enable = true;
    wireshark = { enable = true; usbmon.enable = true; };
  };

  services = {
    mullvad-vpn = { enable = true; gui.enable = true; };
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    udisks2 = { enable = true; mountOnMedia = true; };
    pipewire = { enable = true;
      wireplumber.enable = true; alsa.enable = true; pulse.enable = true;
      jack.enable = lib.mkDefault false; # enable as needed
    };
    inputplumber.enable = true;
    ratbagd.enable = true;
    # I don't use xorg everywhere, so sometimes these are just for the tty
    # TODO: set these some other way, either console.keymap or interceptor
    xserver.xkb.options = "altwin:swap_alt_win,caps:escape,shift:both_capslock";
  };

  xdg.portal = lib.mkDefault {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common = {
      default = "gtk";
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
      # "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
    };
    wlr = {
      enable = true;
      settings.screencast = {
        chooser_type = "dmenu";
        chooser_cmd  = "${pkgs.rofi}/bin/rofi -dmenu -i -p 'Screen to share'";
        max_fps = 60;
      };
    };
  };

  users.users.julia.extraGroups = [ "dialout" "netdev" ];
}
