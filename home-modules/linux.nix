{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    util-linux
    usbtop
    powertop tlp
    lm_sensors
    sysz
    element
  ];

  targets.genericLinux.enable = true;
  xdg = {
    enable = true; mime.enable = true;
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
    mimeApps = { enable = true;
      defaultApplications = {
        "application/pdf" = "zathura.desktop";
        "text/html" = "firefox.desktop";
        "x-scheme-handler/tg" = "org.telegram.desktop";
      };
    };
  };
  i18n.glibcLocales = pkgs.glibcLocalesUtf8;
}
