{ fetchFromGitHub, stdenv, ncurses }:
stdenv.mkDerivation rec {
  pname = "ascii-rain";
  version = "2026-01-12";
  src = fetchFromGitHub {
    owner = "nkleemann";
    repo = "ascii-rain";
    rev = "39396dea0a84b4580f0ee5f46de9de4468566ed0";
    hash = "sha256-v2YN5epe3ZIkjc7he9Kc62v9Oalepu7t3vGzNFRNr3M=";
  };
  nativeBuildInputs = [ ncurses ];
  buildPhase = "cc rain.c -o rain -lncurses";
  installPhase = ''
    mkdir -p $out/bin
    cp rain $out/bin
  '';

  meta.mainProgram = "rain";
}
