{ lib, stdenv, fetchFromGitHub, makeDesktopItem, pkgs }: stdenv.mkDerivation rec {
  pname = "circuit-artist";
  version = "2026-01-06";

  src = fetchFromGitHub {
    owner = "lets-all-be-stupid-forever";
    repo = "circuit-artist";
    rev = "68b5f25eb16098e852f9ae98eb2141bd172e6b55";
    hash = "sha256-FuGeNPXO2CWuiZu7Tz2go1eRQqyYZOwpzHmMiw6yb98=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = with pkgs; [
    cmake
    wayland-scanner
    pkg-config
    makeWrapper
    copyDesktopItems
  ];

  buildInputs = with pkgs; [
    wayland
    gtk3
    glib
    alsa-lib
    libsysprof-capture
    pcre2
     
    util-linux
    libselinux
    libsepol
    libthai
    libdatrie
    
    libxkbcommon
    libxdmcp
    lerc
    libdeflate
    xz
    zstd
    libwebp
    libepoxy
  ]
  ++ (with pkgs.xorg; [
    libX11
    libXrandr
    libXinerama
    libXcursor
    libXi
    libXtst
  ]);
  cmakeBuildTarget = "ca";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp -r $src/assets $src/solutions $out
    mkdir -p $out/share/icons/hicolor/32x32/apps
    cp $src/assets/icon32.png $out/share/icons/hicolor/32x32/apps/circuit-artist.png
    mv ca $out/bin/ca-unwrapped
    makeWrapper $out/bin/ca-unwrapped $out/bin/ca \
      --run 'export data_dir="''${XDG_DATA_HOME:-$HOME/.local/share}/circuit-artist"' \
      --run 'mkdir -p "$data_dir/bin"' \
      --run 'cd "$data_dir/bin"' \
      --run "ln -sfn $out/assets ../assets"

    runHook postInstall
  '';


  desktopItems = [
    (makeDesktopItem {
      name = pname;
      desktopName = pname;
      exec = "ca";
      icon = "circuit-artist";
    })
  ];

  meta = {
    description = "Digital circuit drawing and simulation game";
    homepage = "https://github.com/lets-all-be-stupid-forever/circuit-artist";
    license = lib.licenses.gpl3Only;
    mainProgram = "ca";
    platforms = lib.platforms.linux;
  };
}
