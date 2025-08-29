{ lib, python311, fetchFromGitHub, python311Packages, fetchPypi }:

python311.pkgs.buildPythonApplication rec {
  pname = "basic-pitch";
  version = "2025-01-17";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "spotify";
    repo = pname;
    rev = "f423902aba4b25b4ec80ffa9848b2ad141092a6a";
    hash = "sha256-tqjFmRABVMOsC1eogPlzogj9hdYMWDJIgnX1pNse+NY=";
  };

  build-system = with python311.pkgs; [
    cython
    setuptools
    wheel
  ];

  dependencies = let
    pretty-midi = python311Packages.buildPythonPackage rec {
      pname = "pretty_midi";
      version = "0.2.10";
      src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-6m4ZL5QERnToMzNuofQVMY3fKOMgMCrHsQnt/w1FNL0=";
      };
    };
    tflite-runtime = python311Packages.buildPythonPackage rec {
      pname = "tflite-runtime";
      version = "2.14.0";
      src = fetchPypi {
        inherit pname version;
        sha256 = "";
      };
    };

  in with python311.pkgs; [
    # coremltools
    librosa
    mir-eval
    numpy
    onnxruntime
    pretty-midi
    resampy
    scikit-learn
    scipy
    tensorflow # tensorflow-macos
    tflite-runtime
    typing-extensions
  ];

  optional-dependencies = with python311.pkgs; {
    data = [
      apache-beam
      basic-pitch
      ffmpeg-python
      mirdata
      smart-open
      sox
    ];
    onnx = [ onnxruntime ];
    test = [ basic-pitch coverage mido pytest pytest-mock wave ];
    tf = [ tensorflow ]; #tensorflow-macos
    # coreml = [ coremltools ];
  };

  pythonImportsCheck = [ "basic_pitch" ];

  meta = {
    description = "A lightweight yet powerful audio-to-MIDI converter with pitch bend detection";
    homepage = "https://github.com/spotify/basic-pitch";
    license = lib.licenses.asl20;
    broken = true;
    platforms = [ "x86_64-linux" ]; # need coremltools for darwin support
  };
}
