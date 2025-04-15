{ stdenv, fetchFromGitHub, cmake, ninja, pkg-config, makeWrapper,
  glfw, zlib, mesa, vulkan-loader, vulkan-headers }: stdenv.mkDerivation {
  pname = "glkitty";
  version = "2025-03-04";

  src = fetchFromGitHub {
    owner = "michaeljclark"; repo = "glkitty";
    rev = "dc407ae259a897fe610973bf8ab98ecd3cbd1aec";
    hash = "sha256-4amrbFilb4UUX3/eGy2Q/wL5MJklXhWgzYr/lUDeDmQ=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    glfw
    zlib
    mesa
    vulkan-headers
    vulkan-loader
  ];

  cmakeFlags = [
    "-DEXTERNAL_GLFW=OFF"
    "-DEXTERNAL_GLAD=OFF"
    "-DEXTRA_LIBS=glapi"
    "-DOPENGL_EXAMPLES=OFF"
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 -t $out/bin kitty_gears
    install -Dm644 ../shaders/gears.v120.fsh $out/bin/shaders/gears.fsh
    install -Dm644 ../shaders/gears.v120.vsh $out/bin/shaders/gears.vsh
    makeWrapper $out/bin/kitty_gears $out/bin/glkitty --chdir $out/bin

    runHook postInstall
  '';

  meta = {
    description = "Port of the OpenGL gears demo to kitty terminal graphics protocol";
    homepage = "https://github.com/michaeljclark/glkitty";
    # TODO: investigate osmesa removal:
    # https://gitlab.freedesktop.org/mesa/mesa/-/commit/027ccd96
    # https://github.com/NixOS/nixpkgs/pull/383432
    broken = true; # stdenv.isDarwin;
  };
}
