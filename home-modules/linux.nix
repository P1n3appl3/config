{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    util-linux
    usbtop
    powertop tlp # TODO: powertop kitty terminfo and tlp locales
    lm_sensors
    sysz
    element
  ];
  # TODO: figure out nss for eza/htop, maybe use nsncd?

  targets.genericLinux.enable = true;
  xdg = {
    enable = true; mime.enable = true;
    userDirs = let home = config.home.homeDirectory; in {
      enable = true;
      desktop = home;
      templates = home + "/.templates";
      publicShare = null;
      # TODO: eza use the right icons for these
      documents = home + "/documents";
      download = home + "/downloads";
      music = home + "/music";
      pictures = home + "/images";
    };
    mimeApps = { enable = true;
      # TODO: test if these work and add others
      # defaultApplications = {
      #   "application/pdf" = "zathura.desktop";
      #   "text/html" = "firefox.desktop";
      # };
      # TODO: remove associations for wine, add associations for osu/slp/etc.
    };
  };
  i18n.glibcLocales = pkgs.glibcLocalesUtf8;
}
