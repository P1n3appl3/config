{pkgs, ...}: let
  iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
  nixGL = pkg: let bins = "${pkg}/bin"; in
    pkgs.buildEnv {
      name = "nixGL-${pkg.name}";
      paths = [ pkg ] ++ (map
        (bin: pkgs.hiPrio (
          pkgs.writeShellScriptBin bin ''
            exec -a "$0" "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel" "${bins}/${bin}" "$@"
          ''))
        (builtins.attrNames (builtins.readDir bins)));
    };
in {
  imports = [ ./fonts.nix ];

  home.packages = with pkgs; [
    i3 i3status-rust
    xclip clipmenu maim xcolor
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
    # TODO: vlc save position+https://gpodder.github.io/docs/extensions/mprislistener.html
    gpodder # TODO: sync with dragon using cortana and test mrpis2 with statusbar
    # TODO: try xinput2 and select file picker: https://nixos.wiki/wiki/Firefox
    (nixGL (firefox.override { cfg.speechSynthesisSupport = false; }))
    # TODO: krisp see https://github.com/NixOS/nixpkgs/issues/195512
    (discord.override { withOpenASAR = true; withVencord = true; })
    # TODO: figure out why fractal-next misses the cache
    (nixGL telegram-desktop) (nixGL caprine-bin) signal-desktop fractal
    (nixGL (calibre.override { speechd=null; }))
    # TODO: build from HEAD to get https://git.pwmt.org/pwmt/zathura/-/merge_requests/80
    # until they cut a new release
    zathura # TODO: set up mime types
    obsidian # TODO: config and editor support
    # TODO: package butter for backups
    # obs-studio inkscape kdenlive blender godot lmms audacity krita, maybe in "media"
    # rizin cutter # TODO: try these
    nixgl.nixGLIntel nixgl.nixVulkanIntel
    glxinfo vulkan-tools
  ];

  nixpkgs.config.allowUnfree = true; # discord...
  programs = {
    # TODO: gnome-resources
  };

  # TODO: how to combine?
  # systemd.user.services.clipmenu.Service.Environment =
  #  (lib.mkAfter ["CM_SELECTIONS=clipboard"]);
  services = {
    clipmenu.enable = true;
    udiskie.enable = true;
    syncthing = { enable = true; tray.enable = true; };
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
