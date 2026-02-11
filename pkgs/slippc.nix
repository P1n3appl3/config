{ lib, stdenv, fetchFromGitHub, xz }: stdenv.mkDerivation rec {
  pname = "slippc";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "pcrain";
    repo = "slippc";
    rev = version;
    hash = "sha256-DHJLRT3BqnqFS8NLfqX7pwSRNyJGXRfNyPyzqM2NBjU=";
  };

  buildInputs = [ xz ];

  installPhase = ''
    mkdir -p $out/bin
    cp $pname $out/bin
  '';

  meta = {
    description = "Slippi replay parser, compressor, and basic analysis program";
    homepage = "https://github.com/pcrain/slippc";
    changelog = "https://github.com/pcrain/slippc/blob/${src.rev}/changelog.md";
    license = lib.licenses.gpl3Only;
  };
}
