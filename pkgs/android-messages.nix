{ lib
, stdenv
, fetchFromGitHub
}:
stdenv.mkDerivation rec {
  pname = "android-messages";
  version = "5.4.2";

  src = fetchFromGitHub {
    owner = "OrangeDrangon";
    repo = "android-messages-desktop";
    rev = "v${version}";
    hash = "sha256-M6cLfp+higAUBaM7saUeQVK/C9MiiBoP2dzcHQ4Ao5c=";
  };

  meta.broken = true;
}
