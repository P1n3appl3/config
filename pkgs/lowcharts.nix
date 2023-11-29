{fetchFromGitHub, rustPlatform}: rustPlatform.buildRustPackage rec {
  pname = "lowcharts";
  version = "v0.5.8";
  src = fetchFromGitHub {
    owner = "juan-leon";
    repo = pname;
    rev = version;
    hash = "sha256-oCm8U9H5GymDvBp3/Ul2GNYa+6euznE0t0iSXPUZl3Q=";
  };
  doCheck = false; # broken test fixed by next release
  cargoHash = "sha256-hT1N9uOMV8rabjS7YQ45IalTrGpkorKLe31m73fZWjw=";
}
