{ rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage rec {
  pname = "dsrom";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "AetiasHax";
    repo = "ds-rom";
    rev = "v${version}";
    hash = "sha256-yEuZWq0PXPr7hMmr2P0pDhn36BEDeH2hFaCGz8yl5/8=";
  };

  cargoHash = "sha256-BN6q1bChODa07nDPV51qRWs3012fftP44qfvYgb+Muc=";

  doCheck = false;

  meta = {
    description = "CLI for extracting and building DS ROMs";
    homepage = "https://github.com/AetiasHax/ds-rom";
  };
}
