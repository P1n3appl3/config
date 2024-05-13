{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, stdenv, darwin }:
rustPlatform.buildRustPackage rec {
  pname = "cargo-clone-crate";
  version = "unstable-2024-04-19";
  src = fetchFromGitHub {
    owner = "ehuss";
    repo = pname;
    rev = "857711f6e8897741e99be3d5a691c5f5303d949f";
    hash = "sha256-YZt6w8BIJKr1AWWzqhvF7GK1s9DL1+jJefbdWpEE5hA=";
  };
  cargoHash = "sha256-fUhhfYZmzEX8gm3M8SbEeHssLYkSJB3KyFnMZM9jvcY=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  doCheck = false; # it tries to run `git clone` in tests
}
