{
  home = {
    username = "joseph"; homeDirectory = "/home/joseph";
  };
  imports = [
    ../home-modules/linux.nix
    ../home-modules/dev.nix
  ];
}
