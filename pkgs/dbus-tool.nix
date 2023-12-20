{ fetchFromGitHub, stdenv, autoconf, gnum4, libxml2 }:
stdenv.mkDerivation rec {
  name = "dbus-tool";
  src = fetchFromGitHub {
    owner = "alfmep";
    repo = name;
    rev = "v0.9.3";
    hash = "sha256-jR/BX/pv7OD2yRDu/ZSk5VCBRYI/E8M28XkQ+2m2fwQ=";
  };
  nativeBuildInputs = [ autoconf gnum4 ];
  buildInputs = [ libxml2 ]; # need to package ultrabus
}
