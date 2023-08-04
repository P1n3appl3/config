{ pkgs, ... }: {
  home.packages = with pkgs; [
    util-linux
    usbtop
    lm_sensors
    sysz
  ];
  # TODO: figure out nss for exa/htop, maybe use nsncd?

  # system xdg and other dirs
  targets.genericLinux.enable = true;

  # use a minimal locale-archive without the full 200MB of locales
  i18n.glibcLocales = pkgs.glibcLocalesUtf8;
}
