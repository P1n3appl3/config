{ rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage (finalAttrs: {
  pname = "porkbun-ddns";
  version = "2026-07-07";

  src = fetchFromGitHub {
    owner = "p1n3appl3";
    repo = "porkbun-ddns";
    rev = "4fbbd8b7496e9380287b22316c77359a9a8abc51";
    hash = "sha256-zL8ub7U/sUxPatweKfh7cMxhaNwRBvgKWP6hNa05cVE=";
  };

  cargoHash = "sha256-JM18CX5QjuS+Wq4hUBoO0crjPrhbFFqgu8oK+cemlA0=";

  meta = {
    description = "simple ddns client for porkbun";
    homepage = "https://github.com/p1n3appl3/porkbun-ddns";
    mainProgram = "porkbun-ddns";
  };
})
