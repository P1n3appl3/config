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
    matchBlocks = {
      "pineapple.computer josephis.gay josephryan.me Cortana Cortana.local Cortana.lan" = {
        hostname = "%h"; user = "joseph"; port = 69;
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
        "x-scheme-handler/tg" = "org.telegram.desktop";
      };
    };
  };

  i18n.glibcLocales = pkgs.glibcLocalesUtf8;
}
