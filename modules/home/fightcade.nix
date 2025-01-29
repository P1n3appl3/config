{ config, lib, pkgs, ... }: let
  opts = {
    enable = lib.mkEnableOption ''
      Simple Dynamic DNS client for porkbun that points domains at your current ip
    '';
    path = lib.mkOption {
      type = lib.types.str;
      description = lib.mdDoc "Path to your download of fightcade";
    };
  };

  libs = lib.makeLibraryPath (with pkgs; with pkgs.xorg; [
    alsa-lib
    atk
    cairo
    cups
    dbus
    expat
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libX11
    libxcb
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXScrnSaver
    libXtst
    mesa
    nss
    nspr
    pango
  ]);
  cfg = config.programs.fightcade;
  quark = (pkgs.makeDesktopItem {
    name = "fcade-quark";
    desktopName = "Fightcade Replay";
    exec = ''bash -c "cd ${cfg.path}/emulator && env LD_LIBRARY_PATH=${libs} ./fcade"'';
    mimeTypes = [ "x-scheme-handler/fcade" ];
    type = "Application";
  });
  desktop = (pkgs.makeDesktopItem {
    name = "fightcade";
    desktopName = "Fightcade";
    exec = ''bash -c "cd ${cfg.path} && env LD_LIBRARY_PATH=${libs} ./fc2-electron/fc2-electron"'';
    icon = "${cfg.path}/fc2-electron/resources/app/icon.png";
    comment = "Fightcade";
    type = "Application";
    categories = [ "Game" "Emulator" "ArcadeGame"];
  });
in {
  options.programs.fightcade = opts;
  config = lib.mkIf cfg.enable {
    # TODO: not needed if desktop file is there?
    xdg.mimeApps.defaultApplications."x-scheme-handler/fcade" = "fcade-quark.desktop";
    home.packages = [
      (pkgs.callPackage ( { stdenvNoCC, copyDesktopItems }:
        stdenvNoCC.mkDerivation {
          name = "fightcade-desktop";
          nativeBuildInputs = [ copyDesktopItems ];
          desktopItems = [ quark desktop ];
          phases = [ "installPhase" ];
        }) {}
      )
    ];
  };
}
