{ callPackage, lib, python3, fetchFromGitHub }: let
  textual-autocomplete = callPackage ( { fetchPypi }:
    python3.pkgs.buildPythonPackage rec {
      pname = "textual-autocomplete";
      version = "3.0.0a13";
      pyproject = true;
      src = fetchPypi {
        pname = "textual_autocomplete";
        inherit version;
        hash = "sha256-21pK6VbdfW3s5T9/aV6X8qt1gZ3Za4ocBk7Flms6sRM=";
      };
      build-system = [ python3.pkgs.hatchling ];
      dependencies = with python3.pkgs; [ textual typing-extensions ];
      pythonImportsCheck = [ "textual_autocomplete" ];
      meta = {
        description = "Easily add autocomplete dropdowns to your Textual apps";
        homepage = "https://pypi.org/project/textual-autocomplete";
        license = lib.licenses.mit;
      };
    }) {};

  textual = callPackage ({ fetchPypi }:
    python3.pkgs.buildPythonPackage rec {
      pname = "textual";
      version = "0.86.2";
      pyproject = true;
      src = fetchPypi {
        inherit pname version;
        hash = "sha256-Qwc/nrUtDzilry8SS6aLN4+R0mDfSxyS84Sjtcu7y3A=";
      };
      build-system = [ python3.pkgs.poetry-core ];
      dependencies = with python3.pkgs;
        [ markdown-it-py platformdirs rich typing-extensions ];
      optional-dependencies.syntax = with python3.pkgs;
        [ tree-sitter tree-sitter-languages ];
      pythonImportsCheck = [ "textual" ];
      meta = {
        description = "Modern Text User Interface framework";
        homepage = "https://pypi.org/project/textual";
        license = lib.licenses.mit;
      };
    }) {};
  in python3.pkgs.buildPythonApplication rec {
  pname = "posting";
  version = "2.3.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "darrenburns";
    repo = pname;
    rev = version;
    hash = "sha256-lL85gJxFw8/e8Js+UCE9VxBMcmWRUkHh8Cq5wTC93KA=";
  };

  build-system = [
    python3.pkgs.hatchling
  ];

  dependencies = with python3.pkgs; [
    click
    click-default-group
    httpx
    pydantic
    pydantic-settings
    pyperclip
    python-dotenv
    pyyaml
    textual-autocomplete
    watchfiles
    xdg-base-dirs
  ] ++ [ textual ];

  pythonImportsCheck = [
    "posting"
  ];

  meta = {
    description = "The modern API client that lives in your terminal";
    homepage = "https://github.com/darrenburns/posting";
    license = lib.licenses.asl20;
  };
}
