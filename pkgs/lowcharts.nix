{ fetchFromGitHub, rustPlatform }: rustPlatform.buildRustPackage rec {
  pname = "lowcharts";
  version = "2024-01-27";
  src = fetchFromGitHub {
    owner = "juan-leon";
    repo = pname;
    rev = "a9512730570f131398f2d408ab599dd29d58feb9";
    hash = "sha256-koNJ+sLltFO1aBHzU1+zXbKYx29fvfvcr6LE3RVxeCs=";
  };
  cargoHash = "sha256-JZXrjQU4HPbF5m+nRDizO+nxVcrfFNBzXrwzPcqFY1I=";
}
