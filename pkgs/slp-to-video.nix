{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "slp-to-video";
  version = "2024-04-20";

  src = fetchFromGitHub {
    owner = "MiguelTornero";
    repo = "slp-to-video";
    rev = "d68ae503a9f09c59c786e633654778d6ac0f93c4";
    hash = "sha256-2wIKSx+644vhBc/iZe2fc3hGP+CwWcxkHdlP0GJQLXg=";
    fetchSubmodules = true;
  };

  meta = {
    homepage = "https://github.com/MiguelTornero/slp-to-video";
    mainProgram = "slp-to-video";
  };
}
