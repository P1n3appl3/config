{fetchFromGitHub, rustPlatform} : rustPlatform.buildRustPackage rec {
  pname = "bandwhich";
  version = "2023-05-27";
  src = fetchFromGitHub {
    owner = "jcgruenhage"; repo = pname;
    rev = "c4d5755dde3ffc2cf813926bd93b4b63972147d5";
    hash = "sha256-CNwd79U+yAWtM2oZ+/qgDNjbSFBE8sjyzyXLEaDyc4g=";
  };
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes."packet-builder-0.7.0" = "sha256-ZF3tlREfbzPWXPWuJiQYP6qHucTaYMSEmaG8PFBw+MA=";
  };
  doCheck = false;
}
