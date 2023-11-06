{fetchFromGitHub, rustPlatform, pkg-config,
  meson, gtk4, libadwaita, btrfs-progs, polkit, libclang }:
rustPlatform.buildRustPackage {
  pname = "butter";
  version = "2023-11-05";
  src = fetchFromGitHub {
    owner = "zhangyuannie";
    repo = "butter";
    rev = "a9454c58de5d7d3d551da367f1c6e4781ff8176a";
    hash = "sha256-soIDnbIHDU++wot43hpmvs+CQHX/X6DdLuq+8W3VWic=";
  };
  cargoHash = "sha256-ksNZfurMtDJd+GynuGnVVO/m8VrAZWmKJ6vcxSVV6cY=";
  nativeBuildInputs = [ meson pkg-config ];
  buildInputs = [ btrfs-progs gtk4 libadwaita polkit.dev libclang.lib ];
}
