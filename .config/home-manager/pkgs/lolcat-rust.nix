{fetchFromGitHub, rustPlatform} : rustPlatform.buildRustPackage rec {
  name = "lolcat";
  src = fetchFromGitHub {
    owner = "ur0"; repo = name;
    rev = "9621f625e1d4e7b3294facdc7a2c1cf866af722e";
    hash = "sha256-zy8BD2F49H5jdHxMMlqUJQkHePkrApRL088xC79oP5g=";
  };
  cargoHash = "sha256-JvOD8pGZ3Gn9lbpG/EZsVwFciPeX36Rs8ZkSHDkH0ow=";
}
