{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    i3
    xclip maim xcolor
    dunst
    oneko
    xorg.xkill
    xsnow # TODO: https://github.com/Icelk/xsnow-comp-patch
  ];

  systemd.user.services.clipmenu.Service.Environment = ["CM_SELECTIONS=clipboard"];
  services = {
    clipmenu.enable = true;
    dunst = { enable = true;
      inherit (config.gtk) iconTheme;
      settings = {
        global = {
          monitor = 1;
          frame_color = "#788388";
          frame_width = 0;
          corner_radius = 8;
          width = "(0, 500)";

          font = "sans 12";
          markup = "full";
          max_icon_size = 32;
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

  xsession = { enable = true; windowManager.command = "i3"; };
}
