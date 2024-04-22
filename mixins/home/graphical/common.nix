{pkgs, lib, ...} @ inputs: let
  iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
  nixGL = if inputs ? osConfig then lib.id else
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
    pavucontrol playerctl pamixer
    xdg-utils # TODO: try handlr-regex
    rofimoji
    libqalculate qalculate-gtk
    wezterm rio alacritty
    gnome.nautilus # TODO: pick: fm/nautilus/dolphin/nemo/spacefm/pcmanfm/thunar
    # TODO: https://github.com/tomasklaen/uosc/blob/main/dist/script-opts/uosc.conf
    (nixGL (wrapMpv mpv-unwrapped { scripts = with mpvScripts; [ mpris uosc thumbfast ]; }))
    ffmpeg (nixGL imv) vlc
    vial # TODO: check if I need via too
    gpodder # TODO: sync with dragon using cortana and test mrpis2 with statusbar
    zathura
    (nixGL obsidian)
    buttermanager # maybe https://github.com/digint/btrbk is actually what i want
    # TODO: www.marginalia.nu or ddg default search engine, set profile to
    # automate setting up my userchrome css, sync userstyles
    # TODO: try xinput2 and select file picker: https://nixos.wiki/wiki/Firefox
    # TODO: bitwarden popup floating window
    # TODO: vaapi hardware decode
    (nixGL (firefox.override { cfg.speechSynthesisSupport = false; }))
    (nixGL telegram-desktop) (nixGL caprine-bin) vesktop signal-desktop
    fractal-next nheko # TODO: pick one
    praat friture # TODO: try this for voice training
    # maybe make a "media" module
    # obs-studio kdenlive blender godot
    # non lmms ardour tenacity (or audacity)
    # inkscape krita pinta
    # (nixGL (calibre.override { speechd=null; }))
    # libresprite/acesprite-unfree
    imhex # (TODO: catppuccin) hexerator rizin cutter # TODO: try these
    mepo # TODO: try
    # TODO: syncthing-gtk
    # TODO: https://gitlab.freedesktop.org/rncbc/qpwgraph
    nixgl.nixGLIntel # nixgl.nixVulkanIntel # TODO: debug (llvm update?)
    glxinfo vulkan-tools
    firmware-updater gnome-firmware firmware-manager # TODO: pick one
    graphviz
    libnotify
    warp
  ];

  programs = {
    kitty = { enable = true;
      package = (nixGL pkgs.kitty);
      settings = {
        font_size = lib.mkDefault 12;
        include = "~/.config/kitty/common.conf";
      };
    };
  };

  services = {
    udiskie.enable = true;
    # TODO: configure to use Cortana
    syncthing = { enable = true; tray.enable = true; }; # TODO: use syncthing-gtk for tray
    network-manager-applet.enable = true; # TODO: greyed out available networks?
    # TODO: make reverse scrolling vary based on touchpad,
    # check mute mouse binding and volume keys
    pasystray = { enable = true; extraOptions = ["-grSi" "5" "-N" "none" "-N" "new"]; };
  };

  systemd.user.services = {
    polkit-agent-kde = {
      Unit = {
        Description = "Polkit agent from KDE";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure"; RestartSec = 1; TimeoutStopSec = 10;
      };
    };
  };

  home.keyboard.options = [ "caps:escape" "shift:both_capslock" ];

  home.pointerCursor = {
    gtk.enable = true; x11.enable = true;
    name = "Bibata-Modern-Classic"; package = pkgs.bibata-modern-classic;
    size = lib.mkDefault 28;
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
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-error-bell = 0;
      gtk-decoration-layout = "appmenu:none";
    };
  };

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
      General.theme = "Catppuccin-Mocha-Pink";
    };
}
