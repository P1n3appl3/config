{ lib, buildGoModule, fetchFromGitHub }: buildGoModule rec {
  pname = "protobuf-language-server";
  version = "unstable-2025-02-19";

  src = fetchFromGitHub {
    owner = "lasorda";
    repo = pname;
    rev = "8e82adc0984f3c7a4d5179ad19fd86a034659e76";
    hash = "sha256-R/enXn6korpZxnrDyLXfEDnCnW+OaBfgN1sW9dmcFNg=";
  };

  vendorHash = "sha256-dRria1zm5Jk7ScXh0HXeU686EmZcRrz5ZgnF0ca9aUQ=";

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "A language server implementation for Google Protocol Buffers";
    homepage = "https://github.com/lasorda/protobuf-language-server";
    license = lib.licenses.asl20;
    broken = true;
  };
}
