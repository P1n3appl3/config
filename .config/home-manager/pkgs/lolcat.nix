{ fetchFromGitHub, stdenv }:
stdenv.mkDerivation rec {
  name = "lolcat";
  src = fetchFromGitHub {
    owner = "jaseg";
    repo = name;
    rev = "v1.4";
    hash = "sha256-+Lx6ph77Yzl4BJLgV4SE8jLe757YMCotEOiLAwgK3XM=";
  };
  buildPhase = "make";
  installPhase = ''
    mkdir -p $out/bin
    DESTDIR=$out/bin make install
  '';
}
