{fetchFromGitHub, rustPlatform}: rustPlatform.buildRustPackage rec {
  pname = "cpc";
  version = "1.9.3";
  src = fetchFromGitHub {
    owner = "probablykasper";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-pOrRqmZQKh1TF3WjM22ZPHjUlix6c4HBCxsdk6V/qAE=";
  };
  cargoHash = "sha256-r92gQdzE7NlmYga/7FJQ2r4yg89QoRUHFctQhdbblLU=";
}
