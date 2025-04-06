{ lib, rustPlatform, fetchFromGitHub, makeWrapper, python3 }:
rustPlatform.buildRustPackage {
  pname = "d";
  version = "2023-05-31";

  src = fetchFromGitHub {
    owner = "jdonszelmann";
    repo = "d-rs";
    rev = "985767bb220fa3a321c7e0be5897d0904ae8a951";
    hash = "sha256-H6c3acUNOnOjcDCQ1lEvIAffUbA4eRv0M+z1SPhtKy0=";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ python3 ];

  postInstall = ''
    wrapProgram $out/bin/$pname \
      --suffix PATH : ${lib.makeBinPath [ python3 ]}
  '';

  cargoHash = "sha256-cwfTomB2q9bZf1tgVnDAo/eqF43S02I2pcviMAOR0cc=";

  meta = {
    description = "Jana's data-munging multitool";
    homepage = "https://github.com/jdonszelmann/d-rs";
  };
}
