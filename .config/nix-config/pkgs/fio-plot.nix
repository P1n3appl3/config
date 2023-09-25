{ pkgs, python3, fetchPypi }:

# TODO: fix this package, not sure why I'm seeing `FileExistsError` for the
# scripts, maybe I'm holding `buildPythonApplication` wrong
python3.pkgs.buildPythonApplication rec {
  pname = "fio-plot";
  version = "1.1.7";
  format = "setuptools";
  src = fetchPypi {
    inherit pname version;
    hash  = "sha256-5IVWjpK+gZfQSvJMFD1PFaEfKaXy9lcyzOnfm0UwFbA=";
  };
  nativeBuildInputs = with pkgs; [ fio ];
  propagatedBuildInputs = with python3.pkgs; [
    numpy matplotlib pillow pyparsing
  ];
  # pyan3 is only used for internal documentation
  postPatch = "substituteInPlace ./setup.py --replace \"'pyan3', \" ''";
}
