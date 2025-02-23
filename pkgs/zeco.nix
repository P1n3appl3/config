{ lib, rustPlatform, fetchFromGitHub, stdenv, darwin }:

rustPlatform.buildRustPackage {
  pname = "zeco";
  version = "unstable-2025-02-02";

  src = fetchFromGitHub {
    owner = "julianbuettner";
    repo = "zeco";
    rev = "4903915e3a9c4624d70a62c53676063d6b45161a";
    hash = "sha256-3BPKi2cb4q9a7VGi4CoL4V5A7CBTOlDn9R+eDCxYsDw=";
  };

  cargoHash = "sha256-ORtGwIws4oCYu27K7kiZfgJBIXEuLmR3RAx1hMaSwWI=";

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  meta = {
    description = "Zellij attach via the internet, end to end encrypted";
    homepage = "https://github.com/julianbuettner/zeco";
  };
}
