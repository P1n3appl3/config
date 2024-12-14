{ rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage {
  pname = "easy-i3-neovim-nav";
  version = "2023-03-25";

  src = fetchFromGitHub {
    owner = "tom-anders";
    repo = "easy-i3-neovim-nav";
    rev = "12c295e264055549ef9e6d512067a08253ba15f1";
    hash = "sha256-JX7sdrZ5+5W5xjEMLI4okW6evA4Ud1PnjhvVOMCjEdo=";
  };

  cargoHash = "sha256-Tp8miM7Tbd0ObKNDarx3q2E4IhHTsg4PpknO0swH3Ns=";

  meta = {
    description = "Quickly navigate and resize i3wm windows and Neovim splits with the same keybindings";
    homepage = "https://github.com/tom-anders/easy-i3-neovim-nav";
    mainProgram = "easy-i3-neovim-nav";
  };
}
