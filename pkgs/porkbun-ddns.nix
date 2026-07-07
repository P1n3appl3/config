{ rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage (finalAttrs: {
  pname = "porkbun-ddns";
  version = "2026-07-07";

  src = fetchFromGitHub {
    owner = "p1n3appl3";
    repo = "porkbun-ddns";
    rev = "6bd769cce07ca8dac2a6b0a028711cf0d08e95c0";
    hash = "sha256-Nm6oBMAWxr7bUxgt/MYvQAKemjNIEH4K8t2d3bUAXNY=";
  };

  cargoHash = "sha256-xvYIru9ECYCTk9TnaCnlDSPUH7WG4jCNGHwxruD85i8=";

  meta = {
    description = "simple ddns client for porkbun";
    homepage = "https://github.com/p1n3appl3/porkbun-ddns";
    mainProgram = "porkbun-ddns";
  };
})
