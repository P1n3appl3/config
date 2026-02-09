{ stdenv, fetchFromGitHub, }: stdenv.mkDerivation {
  pname = "hmex";
  version = "2025-09-05";

  src = fetchFromGitHub {
    owner = "AlexanderHarrison";
    repo = "cdat";
    rev = "1059572f8db70485755d81e0721c9f38493046e7";
    hash = "sha256-Yh6OlC1OgzzPBJHt2BmwHsSdi6n0MEMsas3369nzDNE=";
  };

  buildPhase = ''
    cc src/hmex.c -o hmex -O2 \
      -Wall -Wextra -Wpedantic -Wuninitialized -Wcast-qual -Wdisabled-optimization \
      -Winit-self -Wlogical-op -Wmissing-include-dirs -Wredundant-decls -Wshadow \
      -Wundef -Wstrict-prototypes -Wpointer-to-int-cast -Wint-to-pointer-cast \
      -Wconversion -Wduplicated-cond -Wduplicated-branches -Wformat=2 \
      -Wshift-overflow=2 -Wint-in-bool-context -Wvector-operation-performance \
      -Wvla -Wdisabled-optimization -Wredundant-decls -Wmissing-parameter-type \
      -Wold-style-declaration -Wlogical-not-parentheses -Waddress \
      -Wmemset-transposed-args -Wmemset-elt-size -Wsizeof-pointer-memaccess \
      -Wwrite-strings -Wtrampolines -Werror=implicit-function-declaration
  '';

  installPhase = ''
    strip $pname
    mkdir -p $out/bin
    cp $pname $out/bin/$pname
  '';

  meta = {
    description = "Fast, simple, portable SSBM dat file modification tools";
    homepage = "https://github.com/AlexanderHarrison/cdat";
  };
}
