{ pkgs, python3, fetchPypi }:

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
  # I'm not sure why the "scripts" part breaks things but removing it seems to work
  postPatch = ''
      substituteInPlace ./setup.py --replace "'pyan3', " ""
      substituteInPlace ./setup.py --replace \
        "scripts=['bin/fio-plot', 'bin/bench-fio']," ""
    '';
}
