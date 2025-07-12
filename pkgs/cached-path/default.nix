{ lib, rustPlatform, fetchFromGitHub, pkg-config, bzip2, openssl, zstd, stdenv, darwin }:
rustPlatform.buildRustPackage rec {
  pname = "cached-path";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "epwalsh";
    repo = "rust-cached-path";
    rev = "v${version}";
    hash = "sha256-tva/mBVawV+SfRfvItLB1+EJv+b+DA0UuYerEz/bOGo=";
  };

  buildFeatures = [ "build-binary" ];

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    bzip2
    openssl
    zstd
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  doCheck = false;

  meta = {
    description = "Rust utility for accessing both local and remote files through a unified interface";
    homepage = "https://github.com/epwalsh/rust-cached-path";
    changelog = "https://github.com/epwalsh/rust-cached-path/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.asl20;
  };
}
