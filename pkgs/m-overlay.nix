{ fetchFromGitHub, stdenvNoCC, luajitPackages, love, libcap,
  icoutils, makeDesktopItem, copyDesktopItems }: stdenvNoCC.mkDerivation rec {
  name = "m-overlay";
  src = fetchFromGitHub {
    owner = "bkacjios";
    repo = name;
    rev = "v2.1.6";
    hash = "sha256-ZTygeqIXZqjzpKHvxrVSSzwgylPVcP0O4uG17TySXAM=";
  };

  nativeBuildInputs = [
    icoutils
    copyDesktopItems
  ];

  desktopItems = [ (makeDesktopItem {
    desktopName = name; name = name; exec = name; icon = name;
    comment = "Gamecube controller input visualizer for dolphin";
    type = "Application";
    categories = [ "Utility" ];
  }) ];

  postInstall = ''
    icotool -x ${src}/installer/icon.ico
    for size in 16 32 48 64 96 128; do
      install -Dm644 icon_*_$size\x$size\x32.png \
        $out/share/icons/hicolor/$size\x$size/apps/m-overlay.png
    done

    mkdir -p $out/bin
    echo "env LD_LIBRARY_PATH=${libcap.lib}/lib \
      LUA_CPATH=${luajitPackages.luasec}/lib/lua/5.1/ssl.so \
      ${love}/bin/love ${src}/source" > $out/bin/m-overlay
    chmod +x $out/bin/m-overlay
  '';
}
