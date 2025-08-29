{ rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage rec {
  pname = "rssfetch";
  version = "2024-07-06";

  src = fetchFromGitHub {
    owner = "P1n3appl3"; repo = pname;
    rev = "b519185e8db40850a49b9c2de31a6d4158b374f7";
    hash = "sha256-qDGDQ3YHjRVM6fPmI6Pn5TieHuiHIxKFmqOd+U18Sik=";
  };

  cargoHash = "sha256-11Zwam9bRVowESCKGxuyuHXteifUEGmXEPPnToUJxeg=";
}
