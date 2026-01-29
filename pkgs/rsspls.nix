{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, stdenv, darwin }:
rustPlatform.buildRustPackage rec {
  pname = "rsspls";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "wezm";
    repo = "rsspls";
    rev = version;
    hash = "sha256-jF8hd9kc1ZZdKOiF9XGl3wzAjuHZWBUXPgy8+rU+v7w=";
  };

  cargoHash = "sha256-h+IgAa54wzkjagdp5aMS/RJ2lGOBnIRqgGNU92cW7g8=";

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
