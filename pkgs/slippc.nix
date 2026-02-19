{ lib, stdenv, fetchFromGitHub, xz }: stdenv.mkDerivation rec {
  pname = "slippc";
  version = "2026-02-07";

  src = fetchFromGitHub {
    owner = "pcrain";
    repo = "slippc";
    rev = "8d79a665392e491edd62150687a956e45a7a0fe7";
    hash = "sha256-v/qtILvLCku3Vyec3HQbJCXcplTaBozJV9Y3K2JNE7s=";
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
