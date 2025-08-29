{ lib, rustPlatform, stdenv, fetchFromGitHub, pkg-config,
  wrapGAppsHook, atk, cairo, gdk-pixbuf, glib, gtk3, libxkbcommon,
  pango, wayland }: rustPlatform.buildRustPackage rec {
  pname = "minidump-debugger";
  version = "0.3.4";

  src = fetchFromGitHub {
    # TODO: switch back to rust-minidump once https://github.com/rust-minidump/minidump-debugger/pull/17 lands
    owner = "loewenheim";
    repo = "minidump-debugger";
    rev = "cef3691fba8d80605e72dc0595e27616a6176064";
    hash = "sha256-8BMZuQIJS95OTvglnZHWIZBPPeU4c4s3xcelEqnK8vY=";
  };

  cargoHash = "sha256-7g5/oKVuL9pckO3oMemFFWiVKZTDSxGAfUmjATEELgo=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook
  ];

  buildInputs = [
    atk cairo gdk-pixbuf glib gtk3 libxkbcommon pango
  ] ++ lib.optionals stdenv.isLinux [
    wayland
  ];

  meta = {
    description = "An experimental GUI for rust-minidump";
    homepage = "https://github.com/rust-minidump/minidump-debugger";
    changelog = "https://github.com/rust-minidump/minidump-debugger/blob/${src.rev}/RELEASES.md";
  };
}
