{ python3, fetchFromGitHub }: python3.pkgs.buildPythonApplication rec {
  pname = "s2yt";
  version = "0.9.30";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "linsomniac";
    repo = "spotify_to_ytmusic";
    rev = version;
    hash = "sha256-zudAwMnylYTS3kXSfTy/bomKsVG/oVw8Zd2FCaNKjwE=";
  };

  build-system = [
    python3.pkgs.poetry-core
  ];

  dependencies = with python3.pkgs; [
    ytmusicapi
    tkinter
  ];

  pythonImportsCheck = [
    "spotify2ytmusic"
  ];
}

