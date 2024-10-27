# TODO: scale down icon for other sizes
{ stdenv, fetchFromGitea, meson, ninja, cmake, python3, xxd, pkg-config,
  libopus, SDL2, SDL2_mixer, libogg, zlib, xorg, makeWrapper,
  makeDesktopItem, copyDesktopItems}:
stdenv.mkDerivation rec {
  pname = "Apotris";
  version = "4.0.2";

  src = fetchFromGitea {
    domain = "gitea.com";
    owner = "akouzoukos";
    repo = "apotris";
    rev = "v${version}";
    hash = "sha256-w9uv7A1UIn82ORyyvT8dxWHUK9chVfJ191bnI53sANU=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    cmake
    meson
    ninja
    python3
    xxd
    pkg-config
    makeWrapper
    copyDesktopItems
  ];

  buildInputs = [
    SDL2
    SDL2_mixer
    libopus
    libogg
    zlib
  ] ++ (with xorg; [
    libXScrnSaver
    libXcursor
    libXi
    libXfixes
    libXrandr
  ]);

  desktopItems = [ (makeDesktopItem {
    desktopName = pname; name = pname; exec = pname; icon = pname;
    comment = "Block stacking game";
    type = "Application";
    categories = [ "Game" ];
  }) ];

  dontUseCmakeConfigure = true;

  postPatch = ''
    patchShebangs tools/bin2s.py
    substituteInPlace source/liba_window.cpp \
      --replace 'loadAudio("")' 'loadAudio("${builtins.placeholder "out"}/")'
  '';

  installPhase = let
    runDir = ''"''${XDG_DATA_HOME-~/.local/share}/apotris"'';
  in ''
    runHook preInstall

    mkdir -p $out/bin
    mv $pname $out/bin/
    mv assets $out/

    mkdir -p $out/share/icons/hicolor/256x256/apps/
    mv ../dist/Apotris-switch.jpg $out/share/icons/hicolor/256x256/apps/

    wrapProgram $out/bin/Apotris --run 'mkdir -p ${runDir}' --run 'cd ${runDir}'

    runHook postInstall
  '';

  meta.broken = stdenv.isDarwin;
}
