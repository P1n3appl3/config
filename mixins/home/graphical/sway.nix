{ pkgs, lib, config, ... } @ inputs: {
  wayland.windowManager.sway = { enable = true;
   # TODO: change exec line to "systemd-cat -p sway ${pkgs.sway}/bin/sway"
   # TODO: wrapper features?
    catppuccin.enable = true;
    systemd = {
      xdgAutostart = true;
      variables = [ "--all" ]; # TODO: check if importing PATH for xdg-desktop-portal is working
    };
    extraSessionCommands = ''
      export NIXOS_OZONE_WL="1";
    '';
    extraConfigEarly = "include ~/.config/sway/common_config";
    config = null;
  };

  home.packages = with pkgs; [
    wev wl-clipboard slurp grim hyprpicker wlprop
    # TODO: wl-screenrec config (make sure hardware encode is working)
    # TODO: try satty or watershot
    swaynotificationcenter # TODO: try dunst/mako/fnott
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    wluma
    # TODO: oneko wayland port and/or https://github.com/Ibrahim2750mi/linux-goose
  ];

  programs = {
    rofi.package = pkgs.rofi-wayland;
    wpaperd = { enable = true;
      settings.default = {
        path = config.xdg.userDirs.pictures + "/wallpapers";
        apply-shadow = true;
        duration = "30m";
      };
    };
    swaylock = { enable = true;
      catppuccin.enable = true;
      package = if inputs ? osConfig then pkgs.swaylock else pkgs.hello;
      settings = {
        daemonize = true; scaling = "fill"; image = "~/images/lockscreen";
        ignore-empty-password = true; show-failed-attempts = true;
        inside-color = lib.mkForce "1e1e2eaa";
      };
    };
  };

  services = {
    swayidle = { enable = true;
      events = [
        { event = "before-sleep"; command = "playerctl pause"; }
        { event = "before-sleep"; command = "swaylock"; }
        { event = "lock"; command = "swaylock"; }
      ];
      timeouts = let screen = state: "swaymsg 'output * dpms ${state}'"; in [
        { timeout = 110; command = "swaylock"; }
        { timeout = 120; command = screen "off"; resumeCommand = screen "on"; }
      ];
    };
    cliphist.enable = true;
    swaync.enable = true; # TODO: ctp
    swayosd.enable = true; # TODO: ctp
  };

  systemd.user.services = {
    wpaperd = {
      Unit = {
        Description = "Wallpaper daemon";
        PartOf = "graphical-session.target";
        After = "graphical-session.target";
      };
      Install.WantedBy = [ "graphical-session.target" ];
      Service = {
        Restart = "on-failure";
        ExecStart = "${lib.getExe pkgs.wpaperd} -d";
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

  systemd.user.timers = {
    change-lockscreen = {
      Unit.Description = "Swap my lockscreen background";
      Timer = { OnCalendar = "daily"; Persistent = true; };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
