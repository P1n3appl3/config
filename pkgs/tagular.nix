{ lib, rustPlatform, fetchFromGitHub, pkg-config, libxkbcommon, vulkan-loader,
  stdenv, cmake, alsa-lib, wayland }:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "taguar";
  version = "2026-07-26";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "ad-si";
    repo = "taguar";
    rev = "efeb30a3a86886b19f5d7b72ed0486609d325e29";
    hash = "sha256-EoqT/mdNvAHqbW5ObAljTh6Vch5U32rlhV67f4uIaFo=";
  };

  cargoHash = "sha256-+cl2BFi4+WTY7/pyHbN608fCueCOo/DvEKwZ7Soj+RQ=";

  nativeBuildInputs = [
    pkg-config
    cmake
  ];

  buildInputs = [
    libxkbcommon
    vulkan-loader
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    alsa-lib
    wayland
  ];

  cmakeFlags = [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];

  meta = {
    description = "Simple audio tagging desktop app (id3v2, Vorbis Comments";
    homepage = "https://github.com/ad-si/taguar";
    license = lib.licenses.agpl3Only;
    mainProgram = "taguar";
  };
})
