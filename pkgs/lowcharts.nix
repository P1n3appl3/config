{ lib, fetchFromGitHub, rustPlatform }: rustPlatform.buildRustPackage rec {
  pname = "lowcharts";
  version = "0.5.9";
  src = fetchFromGitHub {
    owner = "juan-leon";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-aGg7fCDdoV6N4qoRvcbuuvdgCM6FA1yhn89EUrBpa1Q=";
  };

  cargoHash = "sha256-GClF57pNApoOQZZMTwSYz978qCo0O98Z+ieRuIlUml8=";

  meta = {
    description = "Tool to draw low-resolution graphs in terminal";
    homepage = "https://github.com/juan-leon/lowcharts";
    changelog = "https://github.com/juan-leon/lowcharts/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
  };
}
