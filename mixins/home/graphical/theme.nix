{ pkgs, lib, inputs, ... }: {
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  # TODO: try lavender/sapphire/blue/sky
  catppuccin = { flavour = "mocha"; accent = "blue"; };

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
    catppuccin = { enable = true; size = "compact"; tweaks = [ "rimless" ]; };
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
      package = (pkgs.catppuccin-kvantum.override { accent = "Blue"; variant = "Mocha"; });
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.Theme = "Catppuccin-Mocha-Blue";
    };
}
