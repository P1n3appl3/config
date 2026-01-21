{ lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, openssl, alsa-lib,
  webkitgtk_4_1, gtk3, glib, libsoup_3, cairo, pango, gdk-pixbuf, atk, nodejs,
  pnpm, fetchPnpmDeps, pnpmConfigHook, makeWrapper }: rustPlatform.buildRustPackage rec {
  pname = "onetagger";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "Marekkon5";
    repo = "onetagger";
    rev = "2429a833cbafb9b057bc9e2268806e571a3ca1b5";
    hash = "sha256-EXkuBlOA/qBrgrckyufJ3HgxsaUycbYdfF9PanZ0O4g=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "songrec-0.2.1" = "sha256-pQKU99x52cYQjBVctsI4gdju9neB6R1bluL76O1MZMw=";
    };
  };

  pnpmDeps = fetchPnpmDeps {
    fetcherVersion = 3;
    pname = "${pname}-pnpm-deps";
    inherit version src;
    pnpmLock = ./pnpm-lock.yaml;
    hash = lib.fakeHash;
  };

  nativeBuildInputs = [
    pkg-config
    nodejs
    pnpm
    pnpmConfigHook
    makeWrapper
  ];

  buildInputs = [
    openssl
    alsa-lib
    webkitgtk_4_1
    gtk3
    glib
    libsoup_3
    cairo
    pango
    gdk-pixbuf
    atk
  ];

  pnpmRoot = "client";

  preBuild = ''
    export HOME="$(mktemp -d)"

    cd client
    pnpm install --offline --frozen-lockfile
    pnpm run build
    cd ..
  '';

  # postInstall = ''
  #   wrapProgram "$out/bin/onetagger" \
  #     --set-default WEBKIT_DISABLE_COMPOSITING_MODE 1
  # '';

  meta = with lib; {
    description = "Cross-platform music tagger for DJs";
    homepage = "https://github.com/Marekkon5/onetagger";
    license = licenses.gpl3Only;
  };
}
