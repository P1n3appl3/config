{fetchFromGitHub, rustPlatform}: rustPlatform.buildRustPackage rec {
  pname = "barchart";
  version = "0.2.0";
  src = fetchFromGitHub {
    owner = "jez";
    repo = pname;
    rev = version;
    hash = "sha256-RhgV+Uik2UErCaRfZE8n50DlOWKjrO9AcMHgRC45DxY=";
  };
  cargoHash = "sha256-aPT5Ur2Tm7Fj8zpsaw3iJn/4XU/GCDr/cuaWFlzlxaU=";
}
