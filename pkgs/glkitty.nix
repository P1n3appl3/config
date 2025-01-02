{ stdenv, fetchFromGitHub, cmake, pkg-config, glfw, zlib }: stdenv.mkDerivation {
  pname = "glkitty";
  version = "2022-01-30";

  src = fetchFromGitHub {
    owner = "michaeljclark"; repo = "glkitty";
    rev = "31ee774de7813815b2227d70f8b54b1ef46b1b1d";
    hash = "sha256-tWnlBKCZaRgfWTC64kiNgclts7ctPXPnTzdCaF6oIr8=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    glfw
    zlib
  ];

  meta = {
    description = "Port of the OpenGL gears demo to kitty terminal graphics protocol";
    homepage = "https://github.com/michaeljclark/glkitty";
  };
}
