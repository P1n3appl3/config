{lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, openssl, darwin}:
rustPlatform.buildRustPackage rec {
  name = "cargo-clone-crate";
  version = "unstable-2024-04-05";

  src = fetchFromGitHub {
    owner = "ehuss";
    repo = name;
    rev = "76b7b9e5f0ff948045d4b42b8b3d94971e78fd19";
    hash = "sha256-IwSV9+tEGlbc6m1kxxaEuc+mxVoF8wcUxmsNnNGQrW4=";
  };
  cargoHash = "sha256-wbYzc/reZa/hWX5FpRg2N2oKMe9ixf5tj2ikjEqBvVc=";
  doCheck = false; # tests try to reach crates.io which fails in the sandbox

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ] ++ lib.optionals stdenv.isDarwin [
    darwin.Security
    darwin.SystemConfiguration
  ];
}
