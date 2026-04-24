{ lib, rustPlatform, fetchFromGitHub, pkg-config, stdenv, wayland }:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cos-cli";
  version = "2026-03-06";

  src = fetchFromGitHub {
    owner = "estin";
    repo = "cos-cli";
    rev = "be3da634e8648f88a4734120292e524b3b7b9690";
    hash = "sha256-0LNwlXFBbbvRuwEBLIPj7aqu7F7yi4dC7y4hbAQDGK0=";
  };

  cargoHash = "sha256-dH1EzqLBTh0+IJfMCeNpKWi2CMmufqybM3BvsqiIpNc=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    wayland
  ];

  meta = {
    description = "A CLI utility for COSMIC Wayland toplevel and workspace management";
    homepage = "https://github.com/estin/cos-cli";
    license = lib.licenses.mit;
    mainProgram = "cos-cli";
  };
})
