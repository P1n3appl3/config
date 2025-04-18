{ fetchFromGitHub, rustPlatform, lib }: rustPlatform.buildRustPackage rec {
  pname = "barchart";
  version = "2024-04-15";
  src = fetchFromGitHub {
    owner = "jez";
    repo = pname;
    rev = "55c47d922f5fa5262c4bb4f75aa228964e1b70f2";
    hash = "sha256-M++O6Vu4P8A/a5fXbCKfTgk+MzJNCK43oand602iDqw=";
  };

  cargoHash = "sha256-3sPVuH6whybCkDUFXTsjd3jlnUP1axk1G3HetSF4ayM=";

  meta = {
    description = "Print a bar chart from the command line";
    homepage = "https://github.com/jez/barchart";
    license = lib.licenses.mit;
  };
}
