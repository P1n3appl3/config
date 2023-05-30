{fetchFromGitLab, rustPlatform} : rustPlatform.buildRustPackage rec {
  name = "dotacat";
  src = fetchFromGitLab {
    domain = "gitlab.scd31.com";
    owner = "stephen";
    repo = name;
    rev = "f3b7e7816bed6b84123e066c57cf4003d77a85f1";
    hash = "sha256-y+u9PO01W+IzBatGHZpgOD7cRKjdeuy4/VX7/V9cu3Q=";
  };
  cargoHash = "sha256-uUnxj3Dk9k10UBmS1t3cPflMRFJ5j03Dq1dHtMl8UaY=";
}
