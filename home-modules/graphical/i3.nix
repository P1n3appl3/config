{pkgs, lib, ...}: let
  iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
  # TODO: condition on not being in NixOS (where graphics drivers should Just Work)
  # TODO: maybe upstream a module to nixGL?
  nixGL = pkg: pkgs.buildEnv rec {
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
    i3 i3status-rust
    xclip maim xcolor
    (rofi.override { plugins = [ rofi-calc ]; }) rofimoji libqalculate
    dunst
    oneko
    brightnessctl
    (nixGL kitty)
    pavucontrol
    gnome.nautilus # TODO: pick: fm/nautilus/dolphin/nemo/spacefm/pcmanfm/thunar
    # TODO: https://github.com/tomasklaen/uosc/blob/main/dist/script-opts/uosc.conf
    (nixGL (wrapMpv mpv-unwrapped { scripts = with mpvScripts; [ mpris uosc thumbfast ]; }))
    ffmpeg (nixGL imv) vlc
    gpodder # TODO: sync with dragon using cortana and test mrpis2 with statusbar
    # TODO: try xinput2 and select file picker: https://nixos.wiki/wiki/Firefox
    (nixGL (firefox.override { cfg.speechSynthesisSupport = false; }))
    # TODO: krisp see https://github.com/NixOS/nixpkgs/issues/195512
    # (nixGL (discord.override { withOpenASAR = true; withVencord = true; }))
    discord
    (nixGL telegram-desktop) (nixGL caprine-bin) signal-desktop fractal-next
    (nixGL (calibre.override { speechd=null; }))
    zathura # TODO: set up mime types
    obsidian # TODO: config and editor support
    # TODO: package butter for backups
    # obs-studio inkscape kdenlive blender godot lmms audacity krita, maybe in "media"
    # rizin cutter # TODO: try these
    nixgl.nixGLIntel nixgl.nixVulkanIntel
    glxinfo vulkan-tools
  ];

  nixpkgs.config.allowUnfree = true; # discord...

  systemd.user.services.clipmenu.Service.Environment = ["CM_SELECTIONS=clipboard"];
  services = {
    clipmenu.enable = true;
    udiskie.enable = true;
    syncthing = { enable = true; tray.enable = true; }; # TODO: fix tray
    network-manager-applet.enable = true;
    # TODO: make reverse scrolling vary based on touchpad,
    # check mute mouse binding and volume keys
    pasystray = { enable = true; extraOptions = ["-grSi" "5" "-N" "none" "-N" "new"]; };
    # TODO: open actions with middle click (and rofi picking?)
    dunst = { enable = true;
      inherit iconTheme;
      settings = {
        global = {
          monitor = 1;
          frame_color = "#788388";
          frame_width = 0;
          corner_radius = 8;
          width = "(0, 500)";

          font = "sans 12";
          markup = "full";
          max_icon_size=32;
          icon_position = "left";
          format = ''%s %p\n%b'';
          show_age_threshold = 60;
          dmenu = "rofi -dmenu -p dunst";
        };
        urgency_low = { background = "#263238"; foreground = "#556064"; };
        urgency_normal = { background = "#263238"; foreground = "#F9FAF9"; };
        urgency_critical = { background = "#D62929"; foreground = "#F9FAF9"; };
      };
    };
  };

  home = {
    keyboard.options = [ "caps:escape" ];
    pointerCursor = {
      gtk.enable = true; x11.enable = true;
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-modern-classic; # TODO: try qogir, catppuccin, and graphite
      size = 28;
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

  # TODO: maybe just grab catppuccin-kvantum settings from sioodmy's config
  qt = { enable = true;
    platformTheme = "gtk";
    style = {
      package = pkgs.arc-kde-theme;
      name = "Arc"; # TODO: debug. this didn't seem to work with dolphin
    };
  };

  xsession = { enable = true; windowManager.command = "i3"; };
}
