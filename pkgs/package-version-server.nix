{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl, stdenv, darwin }:
rustPlatform.buildRustPackage rec {
  pname = "package-version-server";
  version = "0.0.7";

  src = fetchFromGitHub {
    owner = "zed-industries";
    repo = "package-version-server";
    rev = "v${version}";
    hash = "sha256-/YyJ8+tKrNKVrN+F/oHgtExBBRatIIOvWr9mAyTHA3E=";
  };

  cargoHash = "sha256-aO6d7NcWZtLMH2/2jcsD8vpDO+C2exMwxrLVFH3bsP0=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  doCheck = false;

  meta = {
    description = "A language server that handles hover information in package.json files";
    homepage = "https://github.com/zed-industries/package-version-server";
    broken = true;
  };
}
