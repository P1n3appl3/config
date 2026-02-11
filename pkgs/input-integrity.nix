# TODO: icon from https://www.google.com/s2/favicons?sz=64&domain_url=input-integrity.com
# TODO: maybe need to manually run https://github.com/NixOS/patchelf instead of using the
# hook due to an ordering issue
# context here: https://github.com/dotnet/core/blob/main/Documentation/self-contained-linux-apps.md

{ lib, stdenvNoCC, fetchurl, makeWrapper, autoPatchelfHook,
  libz, stdenv, fontconfig, icu, libx11 }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "lossless-adapter-manager";
  version = "2024-03-19";
  src = fetchurl {
    inherit (finalAttrs) pname version;
    url = "https://drive.usercontent.google.com/download?id=1WwRvPNgeafW2MwGbrG1QZ0jOuu_af8XT&confirm=xxx";
    hash = "sha256-zfu0dw9zxXQHKHIS5Ix41//Hf52VI8LkdwXY/0Prykw=";
  };

  dontUnpack = true;

  outputs = [ "out" "lib" ];
  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [
    libz
    stdenv.cc.cc.lib
  ];

  runtimeDependencies = [
    icu
    fontconfig.lib
    libx11
  ];

  buildPhase = ''
    runHook preBuild

    mkdir -p $out/bin $lib
    bin=$out/bin/$pname
    cp $src $bin
    chmod +x $bin
    wrapProgram $bin --set DOTNET_BUNDLE_EXTRACT_BASE_DIR $lib/

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/etc/udev/rules.d
    echo >$out/etc/udev/rules.d/51-losslessadapter.rules <<EOF
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="102b", MODE="0666"
    EOF

    runHook postInstall
  '';

  # needs to run after the patchelf fixup
  # doDist = true;
  distPhase = ''
    runHook preDist
    $bin # run at least once to populate $lib
    runHook postDist
  '';

  meta = {
    mainProgram = finalAttrs.pname;
    platforms = [ "x86_64-linux" ];
    # broken = true;
  };
})
