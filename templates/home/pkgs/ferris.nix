{ rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage rec {
  pname = "motivational-ferris";
  version = "2018-09-14";

  src = fetchFromGitHub {
    owner = "rrbutani";
    repo = pname;
    rev = "8e0fb9696ca5f32f45eff411da1db351321f2cb8";
    hash = "sha256-ZpHLiWFKDNdn3Sjb+1MOOmd9rEn+jg3yNBHvt84zCi4=";
  };

  cargoHash = "sha256-W7uw7gpBmmcSFetCxEnpCr0AlWcrD+YD9bzrlfb9pvE=";
}
