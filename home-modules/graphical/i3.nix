{pkgs, ...}: let
  iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
in {
  imports = [ ./fonts.nix ];

  home.packages = with pkgs; [
    i3 i3status-rust
    xclip clipmenu maim xcolor
    rofimoji libqalculate
    brightnessctl
    oneko
    dunst
    # kitty # TODO: nixgl?
    pavucontrol
    imv mpv ffmpeg
    # TODO: try xinput2 and select file picker: https://nixos.wiki/wiki/Firefox
    (firefox.override { cfg.speechSynthesisSupport = false; })
    # TODO: krisp see https://github.com/NixOS/nixpkgs/issues/195512
    (discord.override { withOpenASAR = true; withVencord = true; })
    telegram-desktop caprine-bin signal-desktop
    # iamb element-desktop cinny-desktop fluffychat # TODO: pick one
    (calibre.override { speechd=null; }) # TODO: does it actually need qt-webengine?
    marble
    # TODO: pick a file browser
    # rizin cutter # TODO: try these
    # TODO: evince or zathura
    # obs-studio inkscape kdenlive blender obsidian
  ];

  nixpkgs.config.allowUnfree = true; # discord...

  programs = {
    rofi = { enable = true; extraConfig = {
        show-icons = true;
        icon-theme = "Papirus-Dark";
        kb-remove-char-forward = "Delete";
        kb-remove-char-back = "BackSpace";
        kb-remove-to-eol = "";
        kb-remove-to-sol = "";
        kb-accept-entry = "Control+m,Return,KP_Enter";
        kb-mode-next = "Shift+Right,Control+Tab,Control+l";
        kb-mode-complete = "Control+c";
        kb-mode-previous = "Shift+Tab,Shift+Left,Control+Shift+Tab,Control+h";
        kb-row-up = "Up,Control+k";
        kb-row-down = "Down,Control+j";
        kb-row-tab = "";
        kb-page-prev = "Control+u";
        kb-page-next = "Control+d";
      };
      font = "monospace 16";
      terminal = "${pkgs.kitty}/bin/kitty";
      plugins = [ pkgs.rofi-calc ];
      theme = ./rofitheme.rasi;
      # TODO: can I filter to just the single file?
      # github says they won't support it so prob not :/
      # TODO: fork and make it 1 column or at least conditional
      # theme = (pkgs.fetchFromGitHub {
      #   owner = "catppuccin"; repo = "rofi";
      #   rev = "5350da41a11814f950c3354f090b90d4674a95ce";
      #   hash = "sha256-DNorfyl3C4RBclF2KDgwvQQwixpTwSRu7fIvihPN8JY=";
      # }) + "/basic/.local/share/rofi/themes/catppuccin-mocha.rasi";
    };
  };

  services = {
    # TODO: make reverse scrolling vary based on touchpad,
    # check mute mouse binding and volume keys
    pasystray = { enable = true; extraOptions = ["-grSi" "5" "-N" "none" "-N" "new"]; };
    udiskie.enable = true;
    network-manager-applet.enable = true;
    # TODO: open actions with middle click (and rofi picking?)
    dunst = {
      inherit iconTheme;
      enable = true; settings = {
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

  # TODO: try qogir, catppuccin, and graphite
  home.pointerCursor = {
    gtk.enable = true; x11.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-modern-classic;
    size = 28;
  };

  gtk = let
    conf = {
      gtk-application-prefer-dark-theme = 1;
      gtk-error-bell = 0;
    };
  in {
    enable = true;
    inherit iconTheme;
    # TODO: try colloid and graphite
    # TODO: check if gtk4 doesn't work without symlinks from catppuccin
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        variant = "mocha"; accents = [ "pink" "lavender" "sapphire" ];
        size = "compact"; tweaks = [ "rimless" ];
      };
    };
    gtk3.extraConfig = conf;
    gtk4.extraConfig = conf;
  };

  # TODO: maybe just grab catppuccin-kvantum settings from sioodmy's config
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      package = pkgs.arc-kde-theme;
      name = "Arc";
    };
  };

  xsession = { enable = true; windowManager.command = "i3"; };
}
