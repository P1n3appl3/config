{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    util-linux
    moreutils
    lsof
    usbtop
    powertop tlp
    lm_sensors
    sysz
    element
  ];

  programs.ssh = { enable = true;
    serverAliveInterval = 30;
    controlPersist = "15h";
    controlMaster = "auto";
    includes = [ "extra-config" ];
    matchBlocks = {
      "pineapple.computer julia.blue Cortana Cortana.local Cortana.lan" = {
        hostname = "%h"; user = "julia"; port = 69;
      };
    };
  };

  targets.genericLinux.enable = true;
  xdg = { enable = true;
    userDirs = let home = config.home.homeDirectory; in {
      enable = true;
      desktop = home;
      templates = home + "/.templates";
      publicShare = null;
      documents = home + "/documents";
      download = home + "/downloads";
      music = home + "/music";
      pictures = home + "/images";
    };

    mime.enable = true;
    mimeApps = { enable = true;
      defaultApplications = {
        "application/pdf" = "zathura.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/tg" = "org.telegram.desktop";
      };
    };
    # don't warn when an app modified the file
    configFile."mimeapps.list".force = true;
  };

  i18n.glibcLocales = pkgs.glibcLocalesUtf8;
}
