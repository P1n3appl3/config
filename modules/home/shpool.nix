{ config, lib, pkgs, ... }: let
  cfg = config.services.shpool;
  toml = pkgs.formats.toml {};
  configFilePath = toml.generate "config.toml" cfg.config;
in {
  options.services.shpool = {
    enable = lib.mkEnableOption (lib.mdDoc "shell persistence daemon");
    config = lib.mkOption {
      default = { }; # TODO, add default and specific options
      type = toml.type;
      description = lib.mdDoc "see <https://github.com/shell-pool/shpool/blob/master/CONFIG.md>";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user = {
      services.shpool = {
        Unit = {
          Description = "Shell Session Pool";
          Requires = "shpool.socket";
        };
        Service = {
          Type = "simple";
          StandardInput = "socket";
          StandardError = "syslog";
          ExecStart = "${lib.getExe pkgs.shpool} -c ${configFilePath} daemon";
          KillMode = "mixed";
          TimeoutStopSec = "2s";
          SendSIGHUP = "yes";
        };
        Install.WantedBy = [ "default.target" ];
      };

      sockets.shpool = {
        Socket = {
          ListenStream = "%t/shpool/shpool.socket";
          SocketMode = "0600";
        };
        Install.WantedBy = [ "sockets.target" ];
      };
    };
  };
}
