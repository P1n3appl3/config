{ lib, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "nasa-wallpaper";
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "davidpob99";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-o86wxxA39lKj1K6KiH9H4+9q3ZeuslisVxz+Bw5JMF4=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "wallpaper-3.2.0" = "sha256-r5LemvZjkwNJIOOr/ihLb1xqiV/PtZeTz2WbTo6/IxA=";
    };
  };

  meta = {
    description = "Change your desktop background with a NASA image";
    homepage = "https://github.com/davidpob99/nasa-wallpaper";
    license = lib.licenses.asl20;
  };
}
