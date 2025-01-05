{ lib, rustPlatform, fetchFromGitHub, fetchpatch }: rustPlatform.buildRustPackage {
  pname = "slpz";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "AlexanderHarrison";
    repo = "slpz";
    rev = "2933983cecc46e34345165accc4608f01b3305dd";
    hash = "sha256-t07HIvjbD0xMrj3uCXEkPfdM9d39uaGYdbkmFZktT34=";
  };

  cargoHash = "sha256-Shx2GzJQP18a+FUQOxLByanRu61+B0fqYvollqIkD7g=";

  meta = {
    description = "Compresses and decompresses Slippi replay (slp) files very quickly";
    homepage = "https://github.com/AlexanderHarrison/slpz";
    license = lib.licenses.asl20;
  };
}
