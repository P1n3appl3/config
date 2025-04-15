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
  cargoHash = "sha256-LEbzKCgR0pJv1qQ19Xk3Yb/7Y+ARmN7qCozGHmC/Tss=";

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
