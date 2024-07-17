{ pkgs, lib, config, ... } @ inputs: let
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
  imports = [ ./fonts.nix ./theme.nix ];

  age.secrets = {
    weather.file = ../../../secrets/weather.age;
  };

  home.packages = with pkgs; [
    (writeShellScriptBin "i3status-rs" ''
      OPENWEATHERMAP_API_KEY=`<${config.age.secrets.weather.path}` \
      exec ${lib.getExe i3status-rust} $@'')
    brightnessctl
    pavucontrol playerctl pamixer audio-select
    xdg-utils # TODO: try handlr-regex
    xorg.xeyes
    rofimoji # TODO: put in rofi plugins section
    libqalculate qalculate-gtk
    wezterm rio alacritty
    nautilus # TODO: pick: fm/nautilus/dolphin/nemo/spacefm/pcmanfm/thunar
    # TODO: https://github.com/tomasklaen/uosc/blob/main/dist/script-opts/uosc.conf
    (nixGL (mpv.override { scripts = with mpvScripts; [ mpris uosc thumbfast ]; }))
    ffmpeg (nixGL imv) vlc
    vial # TODO: check if I need via too
    # gpodder # TODO: sync with dragon using cortana and test mrpis2 with statusbar
    zathura
    (nixGL obsidian)
    # maybe https://github.com/digint/btrbk or buttermanager
    # TODO: www.marginalia.nu or ddg default search engine, set profile to
    # automate setting up my userchrome css, sync userstyles
    # TODO: try xinput2 and select file picker: https://nixos.wiki/wiki/Firefox
    # TODO: bitwarden popup floating window
    # TODO: vaapi hardware decode
    (nixGL firefox)
    (nixGL telegram-desktop) (nixGL caprine-bin) vesktop signal-desktop
    android-messages fractal-next nheko # TODO: pick one
    praat friture # TODO: try this for voice training
    imhex # (TODO: catppuccin) hexerator rizin cutter # TODO: try these
    mepo # TODO: try
    # TODO: syncthing-gtk
    # TODO: https://gitlab.freedesktop.org/rncbc/qpwgraph
    nixgl.nixGLIntel # nixgl.nixVulkanIntel
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
    # TODO: try yofi/wofi/fuzzel
    # TODO: try plugins: rbw/pa source+sink/mpd/systemd/wifi
    rofi = { enable = true;
      catppuccin.enable = true;
      plugins = [ pkgs.rofi-calc ];
    };
  };

  home.file."${config.programs.rofi.configPath}".text = ''@import "extraConfig"'';

  services = {
    udiskie.enable = true;
    syncthing = { enable = true;
      tray = { enable = true; command = "syncthingtray --wait"; };
    };
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
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure"; RestartSec = 1; TimeoutStopSec = 10;
      };
    };
  };

  xdg.portal = { enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
    config.common.default = "*"; # TODO: set per-interface portal
  };

  home.keyboard.options = [ "caps:escape" "shift:both_capslock" ];
}
