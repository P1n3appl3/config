{ lib, rustPlatform, fetchFromGitHub, pkg-config, openssl }:
rustPlatform.buildRustPackage rec {
  pname = "cargo-clone-crate";
  version = "2025-04-07";
  src = fetchFromGitHub {
    owner = "ehuss";
    repo = pname;
    rev = "712f27d75dbb05259508e988b524e1d24e610dbd";
    hash = "sha256-jHYVR9O/FAyVTmcDKzBNp24TUGoF+IRgbg0MBc8nVOk=";
  };
  cargoHash = "sha256-1kzImZEhf+pgFggH093c6uEb1MxUvP766Uhyo3kD1DA=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  doCheck = false; # it tries to run `git clone` in tests
  meta = {
      description = "Cargo subcommand to clone a repo from the registry";
      homepage = "https://github.com/ehuss/cargo-clone-crate";
      license = lib.licenses.mit;
      mainProgram = "cargo-clone";
    };
}
