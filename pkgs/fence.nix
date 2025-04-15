{ stdenv, lib, rustPlatform, fetchFromGitea }: rustPlatform.buildRustPackage rec {
  pname = "fence";
  version = "1.0.0";

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "tiffany";
    repo = "fence";
    rev = "v${version}";
    hash = "sha256-/icXXzB9+Nto4CXsgDfdmYp3sGdwMoyiQvbESasWU8Y=";
  };

  cargoHash = "sha256-RjEWADW37FwgLaBqjfl2vaeHTOpaGbOaTqBwSeyDRRQ=";
  doCheck = false; # problem with nostd

  meta = {
    description = "TUI program to print chess boards";
    homepage = "https://codeberg.org/tiffany/fence";
    licenses = [ lib.licenses.gpl3Only ];
    broken = stdenv.isAarch64;
  };
}
