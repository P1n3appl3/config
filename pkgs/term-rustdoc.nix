{ rustPlatform, fetchFromGitHub, pkg-config, oniguruma, xz }:
rustPlatform.buildRustPackage rec {
  pname = "term-rustdoc";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "zjp-cn";
    repo = "term-rustdoc";
    rev = "v${version}";
    hash = "sha256-fL/qlfNPwffSIGoN8zW5wJFO9jytEw//5CtS6iD0ook=";
  };

  cargoHash = "sha256-UjXVD5dtdLQUEzqJGmDD3NBKS0kv71eUzwMkE+qMqPc=";

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
    broken = true; # TODO: time crate broke type inference? run cargo update?
  };
}
