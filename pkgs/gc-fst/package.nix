{ lib, rustPlatform, fetchFromGitHub, }: rustPlatform.buildRustPackage rec {
  pname = "gc-fst";
  version = "2.1";

  src = fetchFromGitHub {
    owner = "AlexanderHarrison";
    repo = "gc_fst";
    rev = "v${version}";
    hash = "sha256-dTqTIlk+7A18FDgTWGYS1PpWKHguClr5KCSrDAj63Ig=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  meta = {
    description = "Another Gamecube ISO unpacker/rebuilder. I.e. a cross-platform gcrebuilder/gcmod";
    homepage = "https://github.com/AlexanderHarrison/gc_fst";
    license = with lib.licenses; [ asl20 mit ];
    mainProgram = "gc_fst";
  };
}
