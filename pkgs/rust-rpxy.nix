{fetchFromGitHub, rustPlatform}: rustPlatform.buildRustPackage rec {
  pname = "rust-rpxy";
  version = "0.6.2";
  src = fetchFromGitHub {
    owner = "junkurihara";
    repo = pname;
    rev = version;
    hash = "sha256-gLaTHqiUSubfmdR5NjW3wBsV0qpXZuykfvh2YkG97mk=";
  };
}
