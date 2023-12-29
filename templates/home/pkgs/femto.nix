{ clangStdenv, fetchFromGitHub }: clangStdenv.mkDerivation rec {
  pname = "femto";
  version = "2022-01-18";

  src = fetchFromGitHub {
    owner = "p1n3appl3";
    repo = pname;
    rev = "973c5b94926be4a875d1bf3719ff457c9dcc2fbc";
    hash = "sha256-Q0v8RKu7D/aJL0KK7Hl/aZxet+j+IKLxy5l7GSbT5S4=";
  };

  # buildPhase = "make"; # with stdenv make is run by default so this isn't necessary

  installPhase = ''
    mkdir -p $out/bin
    mv femto $out/bin
  '';
}
