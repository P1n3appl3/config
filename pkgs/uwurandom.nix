{ lib, stdenv, linuxPackages, fetchFromGitHub }: stdenv.mkDerivation {
  name = "uwurandom";
  version = "2025-09-20";

  src = fetchFromGitHub {
    owner = "valadaptive";
    repo = "uwurandom";
    rev = "5ae4bb45d1aa7a0af7699f9fa7bd8938b4e14031";
    hash = "sha256-h/CaCyWcgG5VOGGfZDngX2xXn3k3M/Sv2W2EZQTjEfQ=";
  };

  nativeBuildInputs = linuxPackages.kernel.moduleBuildDependencies;
  makeFlags = [
    "KERNEL_DIR=${linuxPackages.kernel.dev}/lib/modules/$(KERNELRELEASE)/build/"
  ];
  buildFlags = [ "kernel" ];
  installPhase = "mkdir $out && strip uwurandom.ko && mv uwurandom.ko $out/";
  allowedReferences = [];

  meta = {
    description = "Like /dev/urandom, but objectively better";
    homepage = "https://github.com/valadaptive/uwurandom";
    license = with lib.licenses; [ gpl2Only mit ];
  };
}
