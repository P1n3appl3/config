{ lib, stdenv, fetchFromGitHub, nodejs, pnpmConfigHook, fetchPnpmDeps,
  electron, copyDesktopItems, makeDesktopItem, makeWrapper }: let
  pname = "bridge";
  version = "3.4.5";

  src = fetchFromGitHub {
    owner = "Geomitron";
    repo = "Bridge";
    rev = "v${version}";
    hash = "sha256-le2Wj2pfq+LbqpmPBE94HfboIwpwQZ8JfyHZozfXEAs=";
  };

  pnpmDeps = fetchPnpmDeps {
    inherit pname version src;

    fetcherVersion = 3;
    hash = "sha256-pUqZZySdd8wihYMNZgU2b1muK+Hh2v330vjY76/2C3w=";
  };

  desktopItem = makeDesktopItem {
    name = pname;
    desktopName = "Bridge";
    comment = "A rhythm game chart searching and downloading tool";
    exec = pname;
    icon = pname;
    categories = [ "Game" "Utility" ];
  };
in stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [
    nodejs
    pnpmConfigHook
    makeWrapper
    copyDesktopItems
  ];

  inherit pnpmDeps;
  dontCheckForBrokenSymlinks = true;
  desktopItems = [ desktopItem ];

  buildPhase = ''
    runHook preBuild

    pnpm install --frozen-lockfile --offline
    pnpm exec ng build -c production
    pnpm exec tsc -p src-electron/tsconfig.electron.json
    node src-electron/rename-to-mjs.js
    pnpm prune --prod
    rm -rf node_modules/.bin

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/${pname}
    cp -R dist $out/share/${pname}/
    cp -R node_modules $out/share/${pname}/
    cp package.json pnpm-lock.yaml $out/share/${pname}/

    install -Dm644 src/assets/icons/icon.png \
      $out/share/icons/hicolor/512x512/apps/${pname}.png

    mkdir -p $out/bin
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --chdir "$out/share/${pname}" \
      --add-flags "$out/share/${pname}/dist/electron/src-electron/main.js"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Rhythm game chart searching and downloading tool. ";
    homepage = "https://github.com/Geomitron/Bridge";
    license = licenses.gpl3Only;
  };
}

