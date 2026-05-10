{ rustPlatform, fetchFromGitHub }: rustPlatform.buildRustPackage {
  pname = "zeco";
  version = "2026-02-21";

  src = fetchFromGitHub {
    owner = "julianbuettner";
    repo = "zeco";
    rev = "8354e4ac7e7f4db851b546bd6d53a7f0872d7de6";
    hash = "sha256-w8V2ukR/I2YxznumM+9qff4CgpD2JwZDrERLL+N7os4=";
  };

  cargoHash = "sha256-Od+quwWNnmvztOvOydFVozZNUejGv8QphZ2dnZyaGm4=";

  meta = {
    description = "Zellij attach via the internet, end to end encrypted";
    homepage = "https://github.com/julianbuettner/zeco";
  };
}
