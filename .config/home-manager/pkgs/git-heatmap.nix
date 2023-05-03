{fetchFromGitHub, lib, makeWrapper, stdenvNoCC, barchart, git, gnugrep} :
stdenvNoCC.mkDerivation rec {
  name = "git-heatmap";
  src = fetchFromGitHub {
    owner = "jez";
    repo = name;
    rev = "97bd9715753e6be01c6cdeb0025b8a8ac25c35cf";
    hash = "sha256-3R7QFuHTWsSpP6qrefsqfpZVJtyFlgPEkVz3SOpb9P0=";
  };
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp $name $out/bin/$name 
    wrapProgram $out/bin/$name \
      --suffix PATH : ${lib.makeBinPath [ git gnugrep barchart ]}
  '';
}
