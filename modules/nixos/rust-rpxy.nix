{ config, lib, pkgs, ... }: let
  cfg = config.services.rust-rpxy;
  toml = pkgs.formats.toml {};
  configFilePath = toml.generate "config.toml" cfg.config;
in {
  options.services.rust-rpxy = {
    enable = lib.mkEnableOption (lib.mdDoc "Rust Reverse Proxy");
    config = lib.mkOption {
      default = { }; # TODO, add default and specific options
      type = toml.type;
      description = lib.mdDoc ''
        Configuration for rust-rpxy. See
        <https://github.com/junkurihara/rust-rpxy/blob/develop/config-example.toml>.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.rust-rpxy ];
    systemd.services.rust-rpxy = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = [ "${pkgs.rust-rpxy}/bin/rpxy --config-file ${configFilePath}" ];
      };
    };
  };
}
