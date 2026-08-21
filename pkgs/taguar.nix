{ lib, rustPlatform, fetchFromGitHub, pkg-config, libxkbcommon, vulkan-loader,
  stdenv, alsa-lib, wayland, opus, autoPatchelfHook }:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "taguar";
  version = "2026-07-26";

  src = fetchFromGitHub {
    owner = "ad-si";
    repo = "taguar";
    rev = "efeb30a3a86886b19f5d7b72ed0486609d325e29";
    hash = "sha256-EoqT/mdNvAHqbW5ObAljTh6Vch5U32rlhV67f4uIaFo=";
  };

  cargoHash = "sha256-+cl2BFi4+WTY7/pyHbN608fCueCOo/DvEKwZ7Soj+RQ=";
  doCheck = false;

  nativeBuildInputs = [
    pkg-config
    autoPatchelfHook
  ];

  buildInputs = [
    (lib.getLib stdenv.cc.cc)
    libxkbcommon
    vulkan-loader
    opus
  ]
  ++ lib.optionals stdenv.hostPlatform.isLinux [
    alsa-lib
  ];

  runtimeDependencies = lib.optionals stdenv.hostPlatform.isLinux [
    wayland
    libxkbcommon.out
  ];

  postPatch = ''
    mkdir -p images
    cat << 'EOF' > images/trash.svg
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <polyline points="3 6 5 6 21 6"></polyline>
      <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
      <line x1="10" y1="11" x2="10" y2="17"></line>
      <line x1="14" y1="11" x2="14" y2="17"></line>
    </svg>
    EOF
  '';

  meta = {
    description = "Simple audio tagging desktop app (id3v2, Vorbis Comments";
    homepage = "https://github.com/ad-si/taguar";
    license = lib.licenses.agpl3Only;
    mainProgram = "taguar";
  };
})
