{ fetchpatch, python3, fetchFromGitHub }: python3.pkgs.buildPythonApplication {
  pname = "mons";
  version = "2.0.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "coloursofnoise";
    repo = "mons";
    rev = "f2b133f3a416da609874cb1695dc142ba9c87a68";
    hash = "sha256-InCK4Q3DZLsvWdfdE/VkwdFeriR/19jYDVyon7432a8=";
  };

  nativeBuildInputs = with python3.pkgs; [ setuptools setuptools-scm wheel ];
  propagatedBuildInputs = with python3.pkgs; [
    dnfile
    pefile
    click
    tqdm
    xxhash
    pyyaml
    urllib3
    platformdirs
  ];

  patches = [ (fetchpatch {
    url = "https://github.com/coloursofnoise/mons/compare/main...p1n3appl3:mons:fixes.diff";
    hash = "sha256-7ftX1esswlOxb2Z/nYYWsbWX0fnrbYDTnkV+057neJE=";
  }) ];

  pythonImportsCheck = [ "mons" ];
}
