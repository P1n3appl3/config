{ lib, rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage rec {
  pname = "factorio-bp-helper";
  version = "0.1.5";

  src = fetchFromGitHub {
    owner = "ComputerDruid";
    repo = "factorio-bp-helper";
    rev = "v${version}";
    hash = "sha256-h+cLc52SRNG1LNfX50s8DpBE25U/NX+soMN28OYgASY=";
  };

  cargoHash = "sha256-g73lIxaNIfeFf5uX5O5oYkDFB6qy7PLI0Sl3B6ovtXY=";

  meta = {
    description = "CLI for manipulating factorio blueprint strings";
    homepage = "https://github.com/ComputerDruid/factorio-bp-helper";
    changelog = "https://github.com/ComputerDruid/factorio-bp-helper/blob/${src.rev}/CHANGELOG.md";
    license = with lib.licenses; [ asl20 mit ];
  };
}
