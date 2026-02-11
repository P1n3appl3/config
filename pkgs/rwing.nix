{ stdenv, lib, fetchurl, makeDesktopItem, copyDesktopItems, glib, gtk3,
libxkbcommon, libxcb, libx11, libGL, fontconfig, vulkan-loader, ... }:
stdenv.mkDerivation rec {
  pname = "rwing";
  version = "alpha-2.3";

  src = fetchurl {
    inherit pname version;
    url = "https://julia.blue/rwing-linux-a2.3";
    hash = "sha256-6BuQQItReOa2xnoMV7xR2yYCdWNrkqNRic/s+VkQf94=";
  };
  icon = fetchurl {
    url = "https://pbs.twimg.com/profile_images/1848475281662828544/4BUEX-m7.png";
    hash = "sha256-DDnhZGcCIUWcwTeRuSdS3Il6XdQh0XxSQ9TqdvjgPck=";
  };

  phases = [ "installPhase" ];
  nativeBuildInputs = [ copyDesktopItems ];
  buildInputs = [
    glib
    gtk3
    libxkbcommon
    libxcb
    libx11
    fontconfig.lib # TODO: debug not showing japanese characters
    vulkan-loader
    libGL
    stdenv.cc.cc.lib
  ];
  libPath = lib.makeLibraryPath buildInputs;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    bin=$out/bin/$pname
    cp $src $bin
    chmod +wx $bin
    patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      --set-rpath ${libPath} $bin

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      desktopName = pname;
      exec = pname;
      icon = icon;
    })
  ];

  meta = {
    description = "Melee vod review tool";
    homepage = "https://melee.cool/rwing";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}

