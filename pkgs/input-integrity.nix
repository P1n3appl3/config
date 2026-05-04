# TODO: icon from https://www.google.com/s2/favicons?sz=64&domain_url=input-integrity.com
{ lib, stdenvNoCC, fetchurl, makeWrapper,
  fontconfig, icu, libx11, libICE, libSM, libusb1, openssl }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "lossless-adapter-manager";
  version = "2026-5-03";
  src = fetchurl {
    inherit (finalAttrs) pname version;
    url = "https://drive.usercontent.google.com/download?id=1WwRvPNgeafW2MwGbrG1QZ0jOuu_af8XT&confirm=xxx";
    hash = "sha256-sKkC0tZk76iQ19pqzWw+163wvgMSPtAtQ4qyH0xEdJ0=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  # it's dlopening these. we can't patchelf cuz it somehow fucks up the binary
  buildInputs = [
    icu
    fontconfig.lib
    libx11
    libICE
    libSM
    libusb1
    openssl
  ];


  installPhase = ''
    runHook preInstall

    install -Dm755 $src $out/bin/$pname
    wrapProgram $out/bin/$pname --prefix LD_LIBRARY_PATH : ${ lib.makeLibraryPath finalAttrs.buildInputs }
    
    mkdir -p $out/etc/udev/rules.d
    cat >$out/etc/udev/rules.d/51-gcadapter.rules <<EOF
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
    EOF
    cat >$out/etc/udev/rules.d/51-losslessadapter.rules <<EOF
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="102b", MODE="0666"
    EOF

    runHook postInstall
  '';

  meta = {
    mainProgram = finalAttrs.pname;
    platforms = [ "x86_64-linux" ];
  };
})
