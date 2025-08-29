{ lib, rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage rec {
  pname = "minidump-stackwalk";
  version = "0.26.0";

  src = fetchFromGitHub {
    owner = "rust-minidump";
    repo = "rust-minidump";
    rev = "v${version}";
    hash = "sha256-TrFFaNgkKfrFZeGKoj0avBkr21OEUYdDgFeDzcrjR8c=";
  };

  cargoHash = "sha256-M8v8VVeWfA/WlhUmQnhy1EQ7gSMK4SvE+EVPI68JyRs=";

  meta = {
    description = "A CLI frontend providing both machine-readable and human-readable digests of a minidump";
    homepage = "https://github.com/rust-minidump/rust-minidump";
    changelog = "https://github.com/rust-minidump/rust-minidump/blob/${src.rev}/RELEASES.md";
    license = lib.licenses.mit;
  };
}
