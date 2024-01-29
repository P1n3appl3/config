{ stdenv, lib, fetchurl, alsaLib, openssl, zlib, pulseaudio, autoPatchelfHook }:

stdenv.mkDerivation rec {
  pname = "j-bin";
  version = "9.4";

  src = fetchurl {
    url = "https://www.jsoftware.com/download/j9.4/install/j9.4_linux64.tar.gz";
    hash = "sha256-4CkijAlenhht8tyk3nBULaBPE0GBf6DVII699/RmmWI=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    alsaLib
    openssl
    zlib
    pulseaudio
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D studio-link-standalone-v${version} $out/bin/studio-link
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://studio-link.com";
    description = "Voip transfer";
    platforms = platforms.linux;
    broken = true;
  };
}
