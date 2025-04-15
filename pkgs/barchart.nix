{ fetchFromGitHub, rustPlatform, lib }: rustPlatform.buildRustPackage rec {
  pname = "barchart";
  version = "2024-04-15";
  src = fetchFromGitHub {
    owner = "p1n3appl3";
    repo = pname;
    rev = "d8e49d2b81f8427d33e34abedac0343aad5b3b54";
    hash = "sha256-M++O6Vu4P8A/a5fXbCKfTgk+MzJNCK43oand602iDqw=";
  };

  cargoHash = "sha256-3sPVuH6whybCkDUFXTsjd3jlnUP1axk1G3HetSF4ayM=";

  meta = {
    description = "Print a bar chart from the command line";
    homepage = "https://github.com/jez/barchart";
    license = lib.licenses.mit;
  };
}
