{ lib, stdenv, darwin, fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "rust-rpxy";
  version = "2024-01-14";

  src = (fetchFromGitHub {
    owner = "junkurihara";
    repo = pname;
    rev = "f38eb97d86f2ab594d0f0238114821480d108d0b";
    hash = "sha256-33enM6NnhQGYsZ2UHTazQr5AG/wL3TmXfMku7dzKiF0=";
    fetchSubmodules = true;
  }).overrideAttrs (_: {
    # https://github.com/NixOS/nixpkgs/issues/195117#issuecomment-1410398050
    GIT_CONFIG_COUNT = 1;
    GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf";
    GIT_CONFIG_VALUE_0 = "git@github.com:";
  });

  buildInputs = lib.optionals stdenv.isDarwin [ darwin.Security ];

  cargoLock.lockFile = ./Cargo.lock;
  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  meta.mainProgram = "rpxy";
}
