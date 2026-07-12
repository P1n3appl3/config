{ rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage (finalAttrs: {
  pname = "porkbun-ddns";
  version = "2026-07-07";

  src = fetchFromGitHub {
    owner = "p1n3appl3";
    repo = "porkbun-ddns";
    rev = "dc2d3f4ed419df093448cb80afe7df22f503a7ba";
    hash = "sha256-E+kb1bNZUNiMQn+S4wtsfRF+14/BYgYKrgcVmw71yF4=";
  };

  cargoHash = "sha256-JM18CX5QjuS+Wq4hUBoO0crjPrhbFFqgu8oK+cemlA0=";

  meta = {
    description = "simple ddns client for porkbun";
    homepage = "https://github.com/p1n3appl3/porkbun-ddns";
    mainProgram = "porkbun-ddns";
  };
})
