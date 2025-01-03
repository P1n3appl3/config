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

  qt = { enable = true;
    platformTheme.name = "qtct";
    style = {
      name = "kvantum"; # TODO: debug why stuff like syncthingtray and dolphin are bad
      package = (pkgs.catppuccin-kvantum.override { accent = "blue"; variant = "mocha"; });
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.Theme = "Catppuccin-Mocha-Blue";
    };
}
