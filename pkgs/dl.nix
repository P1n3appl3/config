{ rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage {
  pname = "dl";
  version = "2024-09-13";

  src = fetchFromGitHub {
    owner = "jdonszelmann"; repo = "dl";
    rev = "cb444427f2b58bf8262a68af2750f1f2c769c818";
    hash = "sha256-UYEEYzVsVyAxEiYveWJLE1C8aM6vlgM07zvp3oprv9s=";
  };

  cargoHash = "sha256-iEj32A/041O2rIh7m6y1TFhBoSVt07VOxuddCzgJMwU=";

  meta = {
    description = "Jana's tool to get the latest download";
    homepage = "https://github.com/jdonszelmann/dl";
  };
}
