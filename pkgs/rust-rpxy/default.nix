{fetchFromGitHub, rustPlatform}: rustPlatform.buildRustPackage rec {
  pname = "rust-rpxy";
  version = "2023-11-17";

  src = fetchFromGitHub {
    owner = "junkurihara";
    repo = pname;
    rev = "f3e8f8445fae19e42f7fe39f93301227ebb764d6";
    hash = "sha256-gLaTHqiUSubfmdR5NjW3wBsV0qpXZuykfvh2YkG97mk=";
    fetchSubmodules = true;
  };

  cargoLock.lockFile = ./Cargo.lock;
  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  # TODO: debug h3 submodule not getting checked out
  # TODO: debug nix-shell Cargo.lock missing
}
