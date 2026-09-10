{ lib, buildNpmPackage, fetchFromGitHub, makeWrapper, ffmpeg, nodejs }:
buildNpmPackage {
  pname = "slp-to-video";
  version = "2024-04-20";

  src = fetchFromGitHub {
    owner = "MiguelTornero";
    repo = "slp-to-video";
    rev = "d68ae503a9f09c59c786e633654778d6ac0f93c4";
    hash = "sha256-zwGB/w0KO05lOgjePEGe8bv/pm6gx//ProR5QDfGrb0=";
  };

  npmDepsHash = "sha256-lBn0iYJm9sW1Fk8bldyeuoLXk8hurYmx5j+A60LroaE=";

  postPatch = ''
    cp ${./package-lock.json} package-lock.json
  '';

  nativeBuildInputs = [
    makeWrapper
  ];

  nodejs = nodejs;

  postInstall = ''
    wrapProgram $out/bin/slp-to-video \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg ]}
  '';

  meta = with lib; {
    description = "A Node.js tool to convert Slippi files to video";
    homepage = "https://github.com/MiguelTornero/slp-to-video";
    license = licenses.mit;
    mainProgram = "slp-to-video";
  };
}
