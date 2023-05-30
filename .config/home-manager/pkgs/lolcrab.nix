{ fetchFromGitHub, rustPlatform }: rustPlatform.buildRustPackage rec {
  name = "lolcrab";
  src = fetchFromGitHub {
    owner = "mazznoer";
    repo = name;
    rev = "084f4caa60a05083e85d0982f052a960db5e677a";
    hash = "sha256-gvfGnLzqSuLL88NKDSeonb3SBGASAj5+JqfmVI6yAxk=";
  };
  cargoHash = "sha256-kBgJF2v3ifHpzV/JtIXWz/S8+Frwln9qfSaFRWzQw48=";
}
