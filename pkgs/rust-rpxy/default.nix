{ lib, stdenv, darwin, fetchFromGitHub, rustPlatform, perl }:
rustPlatform.buildRustPackage rec {
  pname = "rust-rpxy";
  version = "0.8.0";

  src = (fetchFromGitHub {
    owner = "junkurihara"; repo = pname; rev = version;
    hash = "sha256-FsLygu2KFdrIaW6Yc4XKD5zdTDRTYinbvPhNYHQKhUM=";
    fetchSubmodules = true;
  }).overrideAttrs (_: {
    # https://github.com/NixOS/nixpkgs/issues/195117#issuecomment-1410398050
    GIT_CONFIG_COUNT = 1;
    GIT_CONFIG_KEY_0 = "url.https://github.com/.insteadOf";
    GIT_CONFIG_VALUE_0 = "git@github.com:";
  });

  nativeBuildInputs = [ perl ];
  buildInputs = lib.optionals stdenv.isDarwin [ darwin.Security ];

  # TODO: go back to rustls when it works
  buildNoDefaultFeatures = true;
  buildFeatures = [ "native-tls-backend" ];

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "hyper-rustls-0.27.2" = "sha256-oBZ31EoKd4NPHvDaWMMbnk57RpX397ihj0XtiYymP00=";
    };
  };
  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';

  meta.mainProgram = "rpxy";
}
