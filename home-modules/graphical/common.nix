{pkgs, lib, ...} @ inputs: let
  iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
  # TODO: maybe upstream a module to nixGL?
  nixGL = if builtins.hasAttr "osConfig" inputs then lib.id else
    pkg: pkgs.buildEnv rec {
      name = "nixGL-${pkg.name}";
      paths = [ pkg ] ++ [(pkgs.hiPrio (
        pkgs.runCommand name {} ''
          mkdir -p $out/bin
          for bin in "${lib.getBin pkg}"/bin/*; do
            echo > $out/bin/"$(basename "$bin")" \
            "exec -a \"\$0\" ${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel \"$bin\" \"\$@\""
          done;
          chmod +x "$out"/bin/*
          ''))];
    };
in {
  imports = [ ./fonts.nix ];

  home.packages = with pkgs; [
    brightnessctl
    pavucontrol
    rofimoji
    libqalculate qalculate-gtk
    # TODO: remove wezterm fonts https://github.com/wez/wezterm/blob/main/README-DISTRO-MAINTAINER.md#un-bundling-vendored-fonts
    (nixGL kitty) wezterm # TODO: try wezterm multiplexing
    gnome.nautilus # TODO: pick: fm/nautilus/dolphin/nemo/spacefm/pcmanfm/thunar
    # TODO: https://github.com/tomasklaen/uosc/blob/main/dist/script-opts/uosc.conf
    (nixGL (wrapMpv mpv-unwrapped { scripts = with mpvScripts; [ mpris uosc thumbfast ]; }))
    ffmpeg (nixGL imv) vlc
    gpodder # TODO: sync with dragon using cortana and test mrpis2 with statusbar
    zathura # TODO: set up mime types
    (nixGL obsidian)
    # butter # TODO: meson buildRustPackage??? maybe https://github.com/digint/btrbk
    # is actually what i want
    # TODO: www.marginalia.nu or ddg default search engine, set profile to
    # automate setting up my userchrome css, sync stylus if it isn't already
    # TODO: try xinput2 and select file picker: https://nixos.wiki/wiki/Firefox
    (nixGL (firefox.override { cfg.speechSynthesisSupport = false; }))
    # TODO: gtk4cord or webcord
    discord # TODO: check krisp see https://github.com/NixOS/nixpkgs/issues/195512
    (nixGL telegram-desktop) (nixGL caprine-bin) signal-desktop
    fractal-next nheko # TODO: pick one
    (nixGL (calibre.override { speechd=null; }))
    # obs-studio inkscape kdenlive blender godot lmms non audacity krita, maybe in "media"
    # rizin cutter # TODO: try these
    # TODO: syncthing-gtk
    # TODO: https://gitlab.freedesktop.org/rncbc/qpwgraph
    nixgl.nixGLIntel # nixgl.nixVulkanIntel # TODO: debug (llvm update?)
    glxinfo vulkan-tools
  ];

  services = {
    udiskie.enable = true;
    syncthing = { enable = true; tray.enable = true; }; # TODO: use syncthing-gtk for tray
    network-manager-applet.enable = true;
    # TODO: make reverse scrolling vary based on touchpad,
    # check mute mouse binding and volume keys
    pasystray = { enable = true; extraOptions = ["-grSi" "5" "-N" "none" "-N" "new"]; };
  };

  home = {
    keyboard.options = [ "caps:escape" ]; # TODO: check if this works in hyprland too
    pointerCursor = {
      gtk.enable = true; x11.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-modern-classic; # TODO: try qogir, catppuccin, and graphite
      size = lib.mkDefault 28;
    };
  };

  dconf.settings = { "org.gnome.desktop.interface" = { color-scheme = "prefer-dark"; }; };

  gtk = { enable = true;
    inherit iconTheme;
    # TODO: debug https://github.com/catppuccin/gtk/issues/129
    # TODO: try colloid and graphite
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha"; accents = [ "pink" "lavender" "sapphire" ];
        size = "compact"; tweaks = [ "rimless" ];
      };
    };
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; gtk-error-bell = 0; };
  };

  # TODO: see if xdg-desktop-portal/GTK_USE_PORTAL is needed

  # TODO: maybe just grab catppuccin-kvantum settings from sioodmy's config
  qt = { enable = true;
    platformTheme = "qtct";
    style = {
      name = "kvantum"; # TODO: debug why stuff like syncthingtray and dolphin are bad
      # https://www.reddit.com/r/kde/comments/urug5v/guide_to_a_consistent_application_style_in_plasma/
      package = (pkgs.catppuccin-kvantum.override { accent = "Pink"; variant = "Mocha"; });
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = "Catppuccin-Mocha-Mauve";
    };
}
