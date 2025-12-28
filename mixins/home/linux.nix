{ pkgs, lib, config, ... }: {
  home.packages = with pkgs; [
    util-linux
    moreutils
    lsof
    usbtop
    powertop
    lm_sensors
    sysz
    element
    binsider
    netscanner
  ] ++ lib.optionals pkgs.stdenv.isx86_64 [
    lurk
  ];

  # programs.direnv.stdlib = "use angr";

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
      videos = home + "/videos";
    };

    mime.enable = true;
    mimeApps = { enable = true;
      defaultApplications = let ff = "firefox.desktop"; in {
        "application/pdf" = "zathura.desktop";
        "text/html" = ff;
        "x-scheme-handler/http" = ff;
        "x-scheme-handler/https" = ff;
        "x-scheme-handler/tg" = "org.telegram.desktop";
      };
    };
    # don't warn when an app modified the file
    configFile."mimeapps.list".force = true;
  };

  i18n.glibcLocales = pkgs.glibcLocalesUtf8;
}
