{ lib, stdenv, rustPlatform, fetchFromGitHub, cargo-tauri_1, glib-networking, nodejs,
  fetchYarnDeps, yarnConfigHook, wrapGAppsHook4, pkg-config, openssl, webkitgtk_4_1,
  alsa-lib, libsamplerate, gtk3, cairo, gdk-pixbuf, dbus, librsvg, zlib, # cmake,
}: rustPlatform.buildRustPackage (finalAttrs: {
  pname = "recordr";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "benjaminkitt";
    repo = "recordr";
    tag = "v${finalAttrs.version}";
    hash = "sha256-+6oGoYZR2mzHz0LaKpA5cpL5va5oGBkdqMPVA5MIfiM=";
  };

  cargoHash = "sha256-87Aw6D1MUw6YyHkWhVJSNx1WeWjZxwUXMALQdgWfzkU=";

  yarnOfflineCache = fetchYarnDeps {
    yarnLock = finalAttrs.src + "/yarn.lock";
    hash = "sha256-sgtOtzE9rutdBZPaOEV2ho8R/I8Or4dClCllEz5+39E=";
  };

  # TODO: ugh this depends on libsample rate and in their build.rs:
  # https://github.com/Prior99/libsamplerate-sys/blob/master/build.rs
  # they unconditionally build the library from source so i don't think
  # i can use the one from nixpkgs? i'll ask rahul for help patching the
  # build script in a transitive dep

  nativeBuildInputs = [
    cargo-tauri_1.hook

    nodejs
    yarnConfigHook

    pkg-config
    # cmake
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    wrapGAppsHook4
  ];

  # dontUseCmakeConfigure = true;

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [

    glib-networking
    openssl
    webkitgtk_4_1
    alsa-lib
    libsamplerate

    # gtk3
    # cairo
    # gdk-pixbuf
    # glib
    # dbus
    # openssl
    # librsvg
    # zlib
    # stdenv.cc.cc.lib

  ];

  cargoRoot = "src-tauri";
  buildAndTestSubdir = finalAttrs.cargoRoot;

  # buildPhase = ''
  #   npm install
  #   npm run tauri build
  # '';

  # installPhase = ''
  #   mkdir -p $out/bin
  #   cp -r src-tauri/target/release/* $out/bin/
  # '';

  meta = {
    description = "An app for automating the recording of lists of sentences into individual audio files";
    homepage = "https://github.com/benjaminkitt/recordr";
    license = lib.licenses.mpl20;
    broken = true;
  };
})
