{ config, lib, pkgs, ... }: let
  opts = {
    enable = lib.mkEnableOption ''
      Arcade and fighting game emulator and netplay client
    '';
    path = lib.mkOption {
      type = lib.types.str;
      description = lib.mdDoc "Path to your download of fightcade";
    };
  };
  cfg = config.programs.fightcade;

  downloader = builtins.fetchurl {
    url = "https://fightcade.download/fc2json.zip";
    hash = "";
  };

  libs = lib.makeLibraryPath (with pkgs; [
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
    mesa
    nss
    nspr
    pango
    zlib
    wine
    libx11
    libxcb
    libxcomposite
    libxcursor
    libxdamage
    libxext
    libxfixes
    libxi
    libxrandr
    libxrender
    libxscrnsaver
    libxtst
  ]);

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
    home = {
      packages = [
        (pkgs.callPackage ( { stdenvNoCC, copyDesktopItems }:
          stdenvNoCC.mkDerivation {
            name = "fightcade-desktop";
            nativeBuildInputs = [ copyDesktopItems ];
            desktopItems = [ quark desktop ];
            phases = [ "installPhase" ];
          }) {}
        )
      ];

      activation.extractFightcadeDownloader = lib.hm.dag.entryAfter
      [ "writeBoundary" ] ''
        if [ ! -f ${cfg.path}/emulator/fbneo_roms.json ]; then
          unzip -d ${cfg.path}/emulator ${downloader}
        fi
      '';
    };
  };
}
