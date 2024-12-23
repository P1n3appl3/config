{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "tab";
  version = "2024-07-16";

  src = fetchFromGitHub {
    owner = "zserge";
    repo = "tab";
    rev = "20c75b1c246c3284d69a8e951f9c2e56e76afe5b";
    hash = "sha256-O8khaR/B0Yc5oF79h65DR2GLH3vYmn5TmCFTwvqHLb4=";
  };

  buildPhase = "cc tab.c -o tab";
  installPhase = ''
    mkdir -p $out/bin
    cp tab $out/bin
  '';

  meta = {
    description = "A tiny CLI tool to render tabs for 🎹🎷🎺🎸🪕🪈 and other instruments";
    homepage = "https://github.com/zserge/tab";
    license = lib.licenses.mit;
  };
}
