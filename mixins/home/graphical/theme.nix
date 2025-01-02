{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
  ];

  home.pointerCursor = {
    gtk.enable = true; x11.enable = true;
    name = "Bibata-Modern-Classic"; package = pkgs.bibata-modern-classic;
    size = lib.mkDefault 28;
  };

  dconf.settings = { "org.gnome.desktop.interface" = { color-scheme = "prefer-dark"; }; };

  gtk = { enable = true;
    iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-error-bell = 0;
      gtk-decoration-layout = "appmenu:none";
    };
  };

  catppuccin = {
    sway.enable = true; waybar.enable = true; swaylock.enable = true;
    rofi.enable = true;
    kvantum.enable = true;
    zathura.enable = true; imv.enable = true;
    zed.enable = true; obs.enable = true;
  };

  qt = { enable = true;
    platformTheme.name = "kvantum";
    style = {
      name = "kvantum"; # TODO: debug why stuff like syncthingtray and dolphin are bad
      package = (pkgs.catppuccin-kvantum.override { accent = "blue"; variant = "mocha"; });
    };
    # kde.settings."Kvantum/kvantum.kvconfig".General.theme = "Catppuccin-Mocha-Blue";
  };
}
