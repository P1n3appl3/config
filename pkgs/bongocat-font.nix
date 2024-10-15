{ stdenvNoCC, fetchurl, woff2 }:
stdenvNoCC.mkDerivation {
  pname = "bongocat-font";
  version = "1.0";

  src = fetchurl {
    url = "https://julia.blue/fonts/bongocat.woff2";
    hash = "sha256-Wi5SEVxHv59NkTNCR85eAe/WEqTULZjjlATZcUsRe+4=";
  };
  dontUnpack = true;

  nativeBuildInputs = [ woff2 ];

  installPhase = ''
    mkdir -p $out/share/fonts/bongocat
    cp $src bongocat.woff2
    woff2_decompress bongocat.woff2
    cp bongocat.ttf $out/share/fonts/bongocat
  '';
}
