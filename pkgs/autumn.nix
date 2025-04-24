{ lib, fetchFromGitHub, stdenvNoCC, ghc}:
stdenvNoCC.mkDerivation {
  pname = "autumn";
  version = "2025-04-15";
  src = fetchFromGitHub {
    owner = "lynn";
    repo = "autumn";
    rev = "c98d3e521ef68a7d8c934eb35b4e7b412d1adb3c";
    hash = "sha256-T5vHicK35z0Lgpu/SOYXfvekaV3Urp2KRswK6PFvfoU=";
  };
  nativeBuildInputs = [ ghc ];

  buildPhase = "ghc autumn.hs";

  installPhase = ''
    mkdir -p $out/bin
    cp $pname $out/bin/$pname
  '';

  meta = {
    description = "Autumn leaves solitaire game";
    homepage = "https://github.com/lynn/autumn";
    license = lib.licenses.mit;
  };
}
