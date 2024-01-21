{ stdenv, fetchFromGitHub }: stdenv.mkDerivation rec {
  pname = "simple64";
  version = "2023-11-02";

  src = fetchFromGitHub {
    owner = pname; repo = pname;
    rev = "v2023.11.02";
    hash = "sha256-EsXnxnIqGukDbWQhjuHsorQ/Ws0+6gmRKR63O8H9ViA=";
  };
}
