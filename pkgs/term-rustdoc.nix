{ rustPlatform, fetchFromGitHub, pkg-config, oniguruma, xz }:
rustPlatform.buildRustPackage rec {
  pname = "term-rustdoc";
  version = "2025-04-20";

  src = fetchFromGitHub {
    owner = "zjp-cn";
    repo = "term-rustdoc";
    rev = "873925db2eac4a6f161754cfdebf384e78627f9a";
    hash = "sha256-tBdGWT6fjCURkFPgNOJjQVNDtewH0rhKWOkzKqDJrSQ=";
  };

  cargoHash = "sha256-MwmGAYnFX9udauxCyDt2ViNQImv5PNXfmRl56vBOl9M=";
  doCheck = false;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    oniguruma
    xz
  ];

  env = {
    RUSTONIG_SYSTEM_LIBONIG = true;
  };

  meta = {
    description = "A TUI for Rust docs";
    homepage = "https://github.com/zjp-cn/term-rustdoc";
    changelog = "https://github.com/zjp-cn/term-rustdoc/blob/${src.rev}/CHANGELOG.md";
  };
}
