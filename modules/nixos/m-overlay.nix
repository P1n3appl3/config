{ config, lib, pkgs, ... }: let
  cfg = config.programs.m-overlay;
in {
  options.programs.m-overlay = {
    enable = lib.mkEnableOption (lib.mdDoc "Gamecube controller input visualizer");
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.m-overlay ];
    security.wrappers.m-overlay = { # TODO: debug
      owner = "root"; group = "root";
      source = "${pkgs.m-overlay}/bin/m-overlay";
      capabilities = "cap_sys_ptrace=eip";
    };
  };
}
