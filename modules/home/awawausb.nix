{ config, lib, pkgs, ... }:
let
  opts = {
    enable = lib.mkEnableOption ''
      Firefox webusb support extension
    '';
  };
  cfg = config.programs.awawausb;
in
{
  options.programs.awawausb = opts;
  config = lib.mkIf cfg.enable {
    home = {
      # TODO: might need udev rules to do anything useful with this? in which case move
      # to a nixos module and use the /etc native extension path
      packages = [ pkgs.awawausb ];

      file.".mozilla/native-messaging-hosts/awawausb_native_stub.json".text = builtins.toJSON {
        name = "awawausb_native_stub";
        description = "Allows WebUSB extension to access USB devices";
        path = "${lib.getExe pkgs.awawausb}";
        type = "stdio";
        allowed_extensions = [ "awawausb@arcanenibble.com" ];
      };
    };
  };
}
