{ fetchzip, stdenvNoCC }: stdenvNoCC.mkDerivation {
  name = "bibata-modern-classic";
  src = fetchzip {
    url = "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.4/Bibata-Modern-Classic.tar.xz";
    hash = "sha256-YEH6nA8A6KWuGQ6MPBCIEc4iTyllKwp/OLubD3m06Js=";
  };
  installPhase = let dir = "share/icons/Bibata-Modern-Classic"; in ''
    install -dm 0755 $out/${dir} && cp -r * $out/${dir}/
  '';
}
