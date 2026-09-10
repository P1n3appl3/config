{ rustPlatform, fetchFromGitHub, pkg-config, zstd }:
rustPlatform.buildRustPackage rec {
  pname = "peppi-slp";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "hohav";
    repo = "peppi-slp";
    rev = "v${version}";
    hash = "sha256-knJpnUPR8oWrNH0H/Uod4Zm4pQ3u/KR5lQPGakGyLws=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    zstd
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "Inspector & converter for Slippi replays";
    homepage = "https://github.com/hohav/peppi-slp";
    mainProgram = "slp";
  };
}
