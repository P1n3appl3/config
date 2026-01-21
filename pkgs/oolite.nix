{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "oolite";
  version = "2026-01-17";

  src = fetchFromGitHub {
    owner = "OoliteProject";
    repo = "oolite";
    rev = "205bce721a48723f515d702dcf011055935e1864";
    hash = "sha256-kgNuRDyz0+T0a2aNaQaMfvlUmUau1txQVCKAL5KgnDs=";
    fetchSubmodules = true;
  };

  meta = {
    description = "Space exploration role playing game";
    homepage = "https://github.com/OoliteProject/oolite";
    license = lib.licenses.gpl3Only;
    broken = true;
  };
}
