{ rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage {
  pname = "dl";
  version = "2024-09-13";

  src = fetchFromGitHub {
    owner = "jdonszelmann"; repo = "dl";
    rev = "edea9d2fff1125466891cfb11807b6a0c7b30da2";
    hash = "sha256-7ozln2HxdbbdeuCroOprBegR5GC2GWzbHrrJYr44bY0=";
  };

  cargoHash = "sha256-HshEkDJ6Hj9vyHKYEYji/EJVfnUe6F/F3ALCY1kGyUI=";

  meta = {
    description = "Jana's tool to get the latest download";
    homepage = "https://github.com/jdonszelmann/dl";
  };
}
