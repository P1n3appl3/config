{fetchFromGitHub, rustPlatform}:
rustPlatform.buildRustPackage rec {
  name = "netscanner";
  version = "0.4.1";
  src = fetchFromGitHub {
    owner = "Chleba";
    repo = name;
    rev = "v${version}";
    hash = "sha256-E9WQpWqXWIhY1cq/5hqBbNBffe/nFLBelnFPW0tS5Ng=";
  };
  cargoHash = "sha256-iCBcXnQCVuOmdAqD5O/2LZjwhCKJTVXZUVJSNEUhGI0=";
}
