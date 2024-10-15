{ lib, fetchFromGitHub, stdenvNoCC, luajitPackages, love, libcap,
  icoutils, makeDesktopItem, copyDesktopItems, makeWrapper }:
stdenvNoCC.mkDerivation (final: {
  pname = "m-overlay";
  version = "2.1.6";

  src = fetchFromGitHub {
    owner = "bkacjios"; repo = final.pname; rev = "v${final.version}";
    hash = "sha256-ZTygeqIXZqjzpKHvxrVSSzwgylPVcP0O4uG17TySXAM=";
  };

  nativeBuildInputs = [
    icoutils
    copyDesktopItems
    makeWrapper
  ];

  desktopItems = [ (makeDesktopItem {
    desktopName = final.pname; name = final.pname; exec = final.pname; icon = final.pname;
    comment = "Gamecube controller input visualizer for dolphin";
    type = "Application";
    categories = [ "Utility" ];
  }) ];

  postInstall = ''
    icotool -x ${final.src}/installer/icon.ico
    for size in 16 32 48 64 96 128; do
      install -Dm644 icon_*_$size\x$size\x32.png \
        $out/share/icons/hicolor/$size\x$size/apps/m-overlay.png
    done

    mkdir -p $out/bin
    makeWrapper ${lib.getExe love} $out/bin/${final.pname} \
      --prefix LD_LIBRARY_PATH : ${libcap.lib}/lib \
      --set LUA_CPATH ${luajitPackages.luasec}/lib/lua/5.1/ssl.so \
      --add-flags ${final.src}/source
  '';

  meta = {
    mainProgram = final.pname;
    platforms = lib.platforms.linux;
  };
})
