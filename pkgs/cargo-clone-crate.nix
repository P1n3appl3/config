{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, stdenv, darwin }:
rustPlatform.buildRustPackage rec {
  pname = "cargo-clone-crate";
  version = "2024-04-19";
  src = fetchFromGitHub {
    owner = "ehuss";
    repo = pname;
    rev = "a72cf51c424e57c16327f3713b890e8c28757d86";
    hash = "sha256-DfDp2wUNUy/1/kZMQr/arCgPQhSE5UrHZ/Mq/jMo/Kk=";
  };
  cargoHash = "sha256-Sz7bg8Qc5RYzyO54cRKzbeffLGcjEeUiYPD3xliQKac=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ] ++ lib.optionals stdenv.isDarwin
    (with darwin.apple_sdk.frameworks; [ Security SystemConfiguration ]);

  doCheck = false; # it tries to run `git clone` in tests
  meta = {
      description = "Cargo subcommand to clone a repo from the registry";
      homepage = "https://github.com/ehuss/cargo-clone-crate";
      license = lib.licenses.mit;
      mainProgram = "cargo-clone";
    };
}
