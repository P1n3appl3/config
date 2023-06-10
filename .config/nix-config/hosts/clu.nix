{ pkgs, ... }: {
  home = {
    username = "josephry"; homeDirectory = "/home/josephry";
  };
  home.packages = with pkgs; [ powertop ];
  imports = [ ../home-modules/linux.nix ];
}
