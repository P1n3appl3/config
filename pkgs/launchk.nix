{ lib, rustPlatform, fetchFromGitHub, git }:
rustPlatform.buildRustPackage rec {
  pname = "launchk";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "mach-kernel";
    repo = "launchk";
    rev = "launchk-${version}";
    hash = "sha256-j9ZU3owYtbKBG4rxZG7GyWymYsFSGR9OJSV+21KBq/A=";
  };

  cargoHash = "sha256-k/n22Bfg857bWFl8sVhZI3YI2i9JuWmT28zN86W/ing=";

  nativeBuildInputs = [
    rustPlatform.bindgenHook
    git
  ];

  meta = {
    description = "TUI for looking at launchd agents and daemons";
    homepage = "https://github.com/mach-kernel/launchk";
    license = lib.licenses.mit;
    # TODO: runs git at build time to check version, which fails because nix doesn't
    # preserve the git repo maybe?
    broken = true;
  };
}
