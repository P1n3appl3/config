{ lib, rustPlatform, fetchFromGitHub, pkg-config, wrapGAppsHook, atk,
  cairo, expat, fontconfig, freetype, gdk-pixbuf, glib, gtk3, libsoup,
  libxkbcommon, pango, webkitgtk, stdenv, alsa-lib, wayland,
  nodejs, pnpm }:
rustPlatform.buildRustPackage rec {
  pname = "onetagger";
  version = "2025-08-06";

  src = fetchFromGitHub {
    owner = "Marekkon5";
    repo = "onetagger";
    rev = version;
    hash = "sha256-EXkuBlOA/qBrgrckyufJ3HgxsaUycbYdfF9PanZ0O4g=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "songrec-0.2.1" = "sha256-pQKU99x52cYQjBVctsI4gdju9neB6R1bluL76O1MZMw=";
    };
  };

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
    wrapGAppsHook
    nodejs
    pnpm.configHook
  ];

  postPatch = ''
      ln -s ${./pnpm-lock.yaml} client/pnpm-lock.yaml
  '';

  pnpmDeps = pnpm.fetchDeps {
    inherit pname version src;
    fetcherVersion = 2;
    hash = "sha256-nQrt1kIKlSynHcnYPWeDUmPH1Bwxg2TWrWsZm7fTcZQ=";
    sourceRoot = "${src.name}/client";
    postPatch = ''
        ln -s ${./pnpm-lock.yaml} pnpm-lock.yaml
    '';
  };
  pnpmRoot = "client";

  preBuild = ''
    runHook preBuild
    pnpm -C client run build
    runHook postBuild
  '';

  buildInputs = [
    atk
    cairo
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libxkbcommon
    pango
    # libsoup
    # webkitgtk
  ] ++ lib.optionals stdenv.isLinux [
    alsa-lib
    wayland
  ];

  meta = {
    description = "Cross platform music tagger";
    homepage = "https://github.com/Marekkon5/onetagger";
    changelog = "https://github.com/Marekkon5/onetagger/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl3Only;
    broken = true;
  };
}
