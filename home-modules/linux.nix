{ pkgs, ... }: {
  home.packages = with pkgs; [
    util-linux
    usbtop
    lm_sensors
    sysz
  ];
  # TODO: figure out nss for eza/htop, maybe use nsncd?

  targets.genericLinux.enable = true;
  i18n.glibcLocales = pkgs.glibcLocalesUtf8;
}
