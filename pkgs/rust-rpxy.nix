{ fetchFromGitHub, rustPlatform }: rustPlatform.buildRustPackage rec {
  pname = "rust-rpxy";
  version = "0.11.3";

  src = fetchFromGitHub {
    owner = "junkurihara"; repo = pname; rev = version;
    hash = "sha256-LoZ6On/837RJSsf7Qxol83PkczSp+VDk66IBUm/tVWY=";
    fetchSubmodules = true;
  };

  cargoHash = "sha256-L3+kGyeIUHdQfcZ5hHd6YsFYbsyq2R8XwE9HUFJMyd8=";

  meta.mainProgram = "rpxy";
}
