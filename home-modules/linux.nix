{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    util-linux
    usbtop
    lm_sensors
    sysz
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
    };
  };
  i18n.glibcLocales = pkgs.glibcLocalesUtf8;
}
