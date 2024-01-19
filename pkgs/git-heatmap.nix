{fetchFromGitHub, lib, makeWrapper, stdenvNoCC, barchart, git, gnugrep}:
stdenvNoCC.mkDerivation rec {
  pname = "git-heatmap";
  version = "2023-04-16";
  src = fetchFromGitHub {
    owner = "jez";
    repo = pname;
    rev = "97bd9715753e6be01c6cdeb0025b8a8ac25c35cf";
    hash = "sha256-3R7QFuHTWsSpP6qrefsqfpZVJtyFlgPEkVz3SOpb9P0=";
  };
  nativeBuildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp $pname $out/bin/$pname
    wrapProgram $out/bin/$pname \
      --suffix PATH : ${lib.makeBinPath [ git gnugrep barchart ]}
  '';
}
