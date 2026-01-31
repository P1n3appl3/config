{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, stdenv, darwin }:
rustPlatform.buildRustPackage rec {
  pname = "rsspls";
  version = "0.11.3";

  src = fetchFromGitHub {
    owner = "p1n3appl3";
    repo = "rsspls";
    rev = "d20fa5d0f79df5415abb4f7efb5d981c7b6d0994";
    hash = "sha256-ahojJ/FSUZQgb5Ox2BGPBba6PuvAqKXerp4MH+XAdh0=";
  };

  cargoHash = "sha256-UtDpbDRw18oonALl2km6OSapF2YbWGadT+PtGWasWCo=";

  buildFeatures = ["javascript"];

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  meta = {
    description = "Generate RSS feeds from websites";
    homepage = "https://github.com/wezm/rsspls";
    license = with lib.licenses; [ asl20 mit ];
  };
}
