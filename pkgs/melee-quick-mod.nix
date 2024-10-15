{ lib, fetchFromGitHub, stdenvNoCC, python3 }:
stdenvNoCC.mkDerivation rec {
  pname = "melee-quick-mod";
  version = "0.6.0";
  src = fetchFromGitHub {
    owner = "alex-berliner"; repo = "MeleeQuickMod"; rev = version;
    hash = "sha256-d2Ga6lXvagU3ufbzFftRYEM0yRQTpg9CwLlyJhDXniw=";
  };
  installPhase = ''
    mkdir -p $out/bin
    bin=$out/bin/melee-quick-mod
    echo "#!/usr/bin/env bash" > $bin
    echo "${lib.getExe python3} $out/meleequickmod.py \"\$@\"" >> $bin
    chmod +x $bin

    cd $src
    cp meleequickmod.py gcm.py fs_helpers.py version.py $out
  '';
}
