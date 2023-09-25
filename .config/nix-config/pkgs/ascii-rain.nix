{ fetchFromGitHub, stdenv, ncurses }:
stdenv.mkDerivation rec {
  name = "ascii-rain";
  src = fetchFromGitHub {
    owner = "nkleemann";
    repo = name;
    rev = "ba1a986065a6a1c12388306d82c7790135e35be8";
    hash = "sha256-yYZpEevwPppMe9FOZGt5vDkhaeu3zhd2xZycGnT85jI=";
  };
  nativeBuildInputs = [ ncurses ];
  buildPhase = "cc rain.c -o rain -lncurses";
  installPhase = ''
    mkdir -p $out/bin
    cp rain $out/bin
  '';
}
