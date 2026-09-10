{ lib, rustPlatform, fetchFromGitHub, }: rustPlatform.buildRustPackage {
  pname = "hgecko";
  version = "2026-01-05";

  src = fetchFromGitHub {
    owner = "AlexanderHarrison";
    repo = "hgecko";
    rev = "95f3c95a7b067f1d377fb334ae476a9e780b6b1c";
    hash = "sha256-LSQD5XUFU/v9PCjOcuVD/qvCsZfNAV1jkYAZ7Q4Qlp8=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  meta = {
    description = "A reimplementation of Fizzi's gecko tool for use in Training Mode - Community Edition";
    homepage = "https://github.com/AlexanderHarrison/hgecko";
    license = with lib.licenses; [ asl20 mit ];
    mainProgram = "hgecko";
  };
}
