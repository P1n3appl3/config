{ fetchFromGitHub, rustPlatform }: rustPlatform.buildRustPackage rec {
  pname = "barchart";
  version = "0.2.0";
  src = fetchFromGitHub {
    owner = "jez";
    repo = pname;
    rev = version;
    hash = "sha256-RhgV+Uik2UErCaRfZE8n50DlOWKjrO9AcMHgRC45DxY=";
  };
  # its lockfile doesn't have checksums, had to re-generate and check it in here
  cargoLock.lockFile = ./Cargo.lock;
}
