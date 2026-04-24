{ lib, python3, fetchFromGitHub, ffmpeg }:
python3.pkgs.buildPythonApplication (finalAttrs: {
  pname = "slp2mp4";
  version = "3.1.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "davisdude";
    repo = "slp2mp4";
    tag = finalAttrs.version;
    hash = "sha256-lhveXygC/mKa1REzvAWVZqB2Ocw4z27fDeKX81ae30M=";
  };

  build-system = with python3.pkgs; [
    hatch-vcs
    hatchling
  ];

  dependencies = with python3.pkgs; [
    pathvalidate
    tkinter
    tomli-w
  ];

  nativeBuildInputs = [
    python3.pkgs.wrapPython
  ];

  pythonImportsCheck = [
    "slp2mp4"
  ];

  postInstall = ''
    wrapProgram $out/bin/slp2mp4 \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg ]}
    wrapProgram $out/bin/slp2mp4_gui \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg ]}
  '';

  meta = {
    description = "Convert slippi replay files for Super Smash Bros Melee to videos";
    homepage = "https://github.com/davisdude/slp2mp4";
    license = lib.licenses.mit;
    mainProgram = "slp2mp4";
  };
})
