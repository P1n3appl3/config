{ lib, rustPlatform, fetchFromGitHub, pkg-config, libgit2, openssl, zlib, stdenv, darwin }:

rustPlatform.buildRustPackage rec {
  pname = "cargotom";
  version = "0.15.2";

  src = fetchFromGitHub {
    owner = "frederik-uni";
    repo = "cargotom";
    rev = version;
    hash = "sha256-d8YLQHlvbSqsNPEsWnfxNo+yp6lLRELY/Or3Y/HEA/o=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "macros-0.2.0" = "sha256-GrV3KA+Rk62GPPeze/yocnWXRH1rTyK57NSBFFWAJ/s=";
      "taplo-0.13.2" = "sha256-tNo8RsT2V6TPkJM2xEe+8yqYCdC2AOdJY/AXtD0J2bM=";
    };
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libgit2
    openssl
    zlib
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreServices
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  env = {
    OPENSSL_NO_VENDOR = true;
  };

  meta = {
    description = "Language server for Cargo.toml";
    homepage = "https://github.com/frederik-uni/cargotom";
    broken = true;
  };
}
