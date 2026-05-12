{ lib, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "awawausb";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "ArcaneNibble";
    repo = "awawausb";
    tag = "v${finalAttrs.version}";
    hash = "sha256-9VxrTCVhax+R9T6fiGUZ6IbdFOzzP6qumlYcI4rkR8A=";
  };

  sourceRoot = "${finalAttrs.src.name}/native-stub";
  cargoHash = "sha256-By8H8NcxB8cync1MZ+IggKUIb5+XtMIdK9zLcf7uQJg=";

  meta = {
    description = "WebUSB for fopses";
    homepage = "https://github.com/ArcaneNibble/awawausb";
    license = lib.licenses.bsd0;
    mainProgram = "awawausb-native-stub";
  };
})
