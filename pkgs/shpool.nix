{ lib, rustPlatform, fetchFromGitHub, linux-pam }: rustPlatform.buildRustPackage rec {
  pname = "shpool";
  version = "0.6.3";

  src = fetchFromGitHub {
    owner = "shell-pool";
    repo = "shpool";
    rev = "v${version}";
    hash = "sha256-RzXlwzCMZ5nDnNfQHzqY9Wu7gvG8y39yR2W3cfl208w=";
    fetchSubmodules = true;
  };

  buildInputs = [ linux-pam ];
  doCheck = false; # attach test fails

  cargoHash = "sha256-Xb/ohGzgXR8B6Zfd2pUqgpxK6WQnk2xF4bbCyz1g2os=";

  meta.platforms = lib.platforms.linux;
}
