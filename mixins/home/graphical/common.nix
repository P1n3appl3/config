{ pkgs, lib, config, pkgs-stable, ... } @ inputs: let
  nixGL = config.lib.nixGL.wrap;
in {
  imports = [ ./terminal.nix ./fonts.nix ./theme.nix ];

  home.packages = with pkgs; [
    brightnessctl
    pavucontrol playerctl audio-select # pamixer TODO: cmake
    xdg-utils # TODO: try handlr-regex
    xorg.xeyes
    rofimoji # TODO: put in rofi plugins section
    libqalculate qalculate-gtk
    nautilus # TODO: pick: fm/nautilus/dolphin/nemo/spacefm/pcmanfm/thunar
    # TODO: https://github.com/tomasklaen/uosc/blob/main/dist/script-opts/uosc.conf
    (nixGL (mpv.override { scripts = with mpvScripts; [ mpris uosc thumbfast ]; }))
    ffmpeg vlc # (nixGL oculante) # TODO: cmake
    vial # TODO: check if I need via too
    # gpodder # TODO: sync with dragon using cortana and test mrpis2 with statusbar
    zathura
    (nixGL zed-editor)
      # nodejs # TODO: figure out why bundled node isn't working
      # package-version-server
      # protobuf-language-server
      # cargotom
      typescript
    (nixGL obsidian)
    # maybe https://github.com/digint/btrbk or buttermanager
    # TODO: www.marginalia.nu or ddg default search engine, set profile to
    # automate setting up my userchrome css, sync userstyles
    # TODO: try xinput2 and select file picker: https://nixos.wiki/wiki/Firefox
    # TODO: bitwarden popup floating window
    # TODO: vaapi hardware decode, and nightly for webgpu
    (nixGL firefox)

    (nixGL telegram-desktop) (nixGL vesktop) signal-desktop
    (nixGL caprine-bin) slack android-messages
    fractal element-desktop iamb # fluffychat cinny nheko # TODO: pick
    pkgs-stable.friture # praat # TODO: try this for voice training
    # (nixGL imhex) # (TODO: catppuccin) # TODO: try hexerator/rizin/cutter
    mepo # TODO: try
    # TODO: syncthing-gtk
    # TODO: https://gitlab.freedesktop.org/rncbc/qpwgraph
    # nixgl.nixGLIntel nixgl.nixVulkanIntel
    glxinfo vulkan-tools
    firmware-updater gnome-firmware # firmware-manager # TODO: pick one
    graphviz
    libnotify
    warp
    udiskie
    glib.bin # gio/gsettings/gdbus
    d-spy
    transmission_4-gtk
    heaptrack
    (nixGL meld)
    rustdesk
  ];

  programs = {
    # TODO: try anyrun
    # TODO: try plugins: rbw/pa source+sink/mpd/systemd/wifi
    rofi = { enable = true; plugins = [ pkgs.rofi-calc ]; };
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
    pasystray = { enable = true;
      extraOptions = ["-grSi" "1" "-N" "none" "-N" "new" "-m" "100"];
    };
    activitywatch = { enable = true;
      watchers.aw-watcher-afk = {
        package = pkgs.activitywatch;
        settings = { timeout = 300; poll_time = 5; };
      };
    };
    gnome-keyring.enable = true;
  };

  systemd.user.services = {
    polkit-agent-kde = {
      Unit = {
        Description = "Polkit agent from KDE";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Service = {
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure"; RestartSec = 1; TimeoutStopSec = 10;
      };
    };

    change-lockscreen = let script = pkgs.writeShellScript "change-lockscreen" ''
      set -ex
      images="''${XDG_PICTURES_DIR-$HOME/images}"
      new=$(${lib.getExe pkgs.fd} . "$images/wallpapers" -Ltf | shuf -n1)
      ln -sf "$new" "$images/lockscreen"
    ''; in {
      Unit.Description = "Swap my lockscreen background";
      Service = { Type = "oneshot"; ExecStart = "${script}"; };
    };
  };

  xdg.portal = { enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk xdg-desktop-portal-wlr ];
    config.common.default = "gtk"; # TODO: set per-interface portal
  };

  nixGL = lib.optionalAttrs (!(inputs ? osConfig)) {
    packages = inputs.inputs.nixgl.packages;
  };

  home.keyboard.options = [ "caps:escape" "shift:both_capslock" ];
}
