{lib, stdenv, fetchFromGitHub, rustPlatform, pkg-config, openssl, darwin}:
rustPlatform.buildRustPackage rec {
  name = "cargo-clone-crate";
  version = "2023-05-26";
  src = fetchFromGitHub {
    owner = "ehuss";
    repo = name;
    rev = "83408c0489dc1151f908f6d2413fe328fb4ef6ed";
    hash = "sha256-aOnzmXS2/xCWZLRSEGovfQH/Ipva4DAE0rsusBMMOmg=";
  };
  doCheck = false; # tests try to reach crates.io which fails in the sandbox
  cargoHash = "sha256-VDJ903zw9ntuYTXXKaPNzz2ryg3QLtPeXQjCH5AZ8HM=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ] ++ lib.optionals stdenv.isDarwin [ darwin.Security ];
  # not sure whether I need these...
  OPENSSL_NO_VENDOR = true;
  OPENSSL_LIB_DIR = "${lib.getLib openssl}/lib";
  OPENSSL_INCLUDE_DIR = "${openssl.dev}/include";
}
