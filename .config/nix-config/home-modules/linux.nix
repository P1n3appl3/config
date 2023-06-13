{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    util-linux
    usbtop
    lm_sensors
    sysz
  ];
  # TODO: figure out nss for exa/htop, maybe use nsncd?

  # system xdg and other dirs
  targets.genericLinux.enable = true;

  imports = [
    (let # use a minimal locale-archive without the full 200MB of locales
      a = lib.mkForce "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive";
    in {
      systemd.user.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
      home.sessionVariables.LOCALE_ARCHIVE_2_27 = a;
    })
  ];
}
