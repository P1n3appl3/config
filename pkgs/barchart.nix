{ fetchFromGitHub, rustPlatform, lib }: rustPlatform.buildRustPackage rec {
  pname = "barchart";
  version = "2025-05-02";
  src = fetchFromGitHub {
    owner = "jez";
    repo = pname;
    rev = "18993469ebc950adf666b2e0a036bbe6c9b98e0c";
    hash = "sha256-kNBv6ah+E29WN7cjBQgpJ54io8taj70badd2hfjEauU=";
  };

  cargoHash = "sha256-3sPVuH6whybCkDUFXTsjd3jlnUP1axk1G3HetSF4ayM=";

  meta = {
    description = "Print a bar chart from the command line";
    homepage = "https://github.com/jez/barchart";
    license = lib.licenses.mit;
  };
}
