{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "rust-rpxy";
  version = "0.10.3";

  src = fetchFromGitHub {
    owner = "junkurihara"; repo = pname; rev = version;
    hash = "sha256-vrCAdZmdOe7f8RlSrYucYfP2crd/7nEddby+3qpAAo0=";
    fetchSubmodules = true;
  };

  cargoHash = "sha256-SOGJlr7RiAaCARRvMN26B3h51nl2Pj1Y6ePNs6nigZk=";

  meta.mainProgram = "rpxy";
}
