{ lib, stdenv, fetchFromGitHub, pkgs }:
stdenv.mkDerivation {
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
  ];

  buildInputs =
    with pkgs;
    [
      # waylandpp
      wayland
      gtk3
      glib
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

  # installPhase = ''
  #   mkdir -p $out/bin
  #   cp -r $src/assets $out/assets
  #   mv ca $out/bin/ca
  #   makeBinaryWrapper ca --chdir $out/bin
    
  # '';
  installPhase = ''
    mkdir -p $out/bin
    cp -r $src/assets $out
    mv ca $out/bin/ca-unwrapped

    # Wrapper that runs from a per-user writable dir, but keeps ../assets working
    makeWrapper ${pkgs.bash}/bin/bash $out/bin/ca \
      --add-flags -lc \
      --add-flags '
        set -euo pipefail

        data_dir="$${XDG_DATA_HOME:-$$HOME/.local/share}/circuit-artist"
        mkdir -p "$data_dir/bin"

        # Ensure ../assets resolves from $data_dir/bin -> $data_dir/assets -> store assets
        ln -sfn "$out/assets" "$data_dir/assets"

        cd "$data_dir/bin"
        exec "$out/bin/ca-unwrapped" "$@"
      '
  '';

  meta = {
    description = "Circuit Artist is a digital circuit drawing and simulation game";
    homepage = "https://github.com/lets-all-be-stupid-forever/circuit-artist";
    license = lib.licenses.gpl3Only;
    mainProgram = "ca";
    platforms = lib.platforms.linux;
  };
}
