{ stdenv, fetchFromGitHub, cmake, ninja, pkg-config, makeWrapper,
  glfw, zlib, mesa, vulkan-loader, vulkan-headers }: stdenv.mkDerivation {
  pname = "glkitty";
  version = "2022-01-30";

  src = fetchFromGitHub {
    owner = "michaeljclark"; repo = "glkitty";
    rev = "31ee774de7813815b2227d70f8b54b1ef46b1b1d";
    hash = "sha256-tWnlBKCZaRgfWTC64kiNgclts7ctPXPnTzdCaF6oIr8=";
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
    mesa.osmesa
    mesa.drivers
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
    broken = stdenv.isDarwin;
  };
}
