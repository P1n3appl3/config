{ lib, rustPlatform, fetchFromGitHub, pkg-config, wrapGAppsHook, atk,
  cairo, gdk-pixbuf, glib, gtk3, libpulseaudio, pango }:
rustPlatform.buildRustPackage rec {
  pname = "audio-select";
  version = "0.1.1";
  src = fetchFromGitHub {
    owner = "sk8ersteve";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-l09MSKuQrTXE6N1xpZuAqyxPz0uL5oRbtUtV4Pz280U=";
  };
  cargoHash = "sha256-KS+p9W3xi8RJEs45CQGbgpVVG4lolDP3s1zCJ02K34M=";

  nativeBuildInputs = [ pkg-config wrapGAppsHook ];
  buildInputs = [
    atk
    cairo
    gdk-pixbuf
    glib
    gtk3
    libpulseaudio
    pango
  ];

  meta.platforms = lib.platforms.linux;
}
