{ config, lib, pkgs, ... } @ inputs: let
  cfg = config.services.sorcery;
  types = lib.types;
  cache = "/var/cache/sorcery";
  socket = "/run/sorcery/sock";
  control_socket = "/run/sorcery/control";
  pkg = inputs.inputs.sorcery.packages.x86_64-linux;
in {
  options.services.sorcery = {
    enable = lib.mkEnableOption (lib.mdDoc "git repo viewer");
    repositories = lib.mkOption {
      type = types.path;
      description = "Directory where your git repos reside";
    };
    name = lib.mkOption {
      type = types.str;
      description = "Name of your instance";
    };
    url_base = lib.mkOption {
      type = types.str;
      description = "Where your git repos will be accessed from";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkg.default pkg.sorcery-ssh pkg.sorcery-ssh-tui ];
    systemd.services.sorcery = {
      description = "Sorcery Git forge";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      path = [ pkgs.gitMinimal ];
      serviceConfig = {
        ExecStart = [ "${lib.getExe pkg.default}" ];
        Type = "simple";
        User = "git";
        Group = "git";
        RuntimeDirectory = "sorcery";
        CacheDirectory = "sorcery";
        ConfigurationDirectory = "sorcery";
        Restart = "on-failure";
        RestartSec = 2;
        UMask = "0007";
      };
      environment = {
        SORCERY_REPOSITORIES = "${cfg.repositories}";
        SORCERY_INSTANCE_NAME = "${cfg.name}";
        SORCERY_CLONE_URL_BASE = "${cfg.url_base}";
        SORCERY_CACHE = "${cache}";
        SORCERY_SOCKET = "${socket}";
        SORCERY_CONTROL_SOCKET = "${control_socket}";
      };
    };
    services.openssh.extraConfig = ''
      Match User git
        SetEnv SORCERY_CONTROL_SOCKET=${control_socket} SORCERY_INSTANCE_NAME=${cfg.name} SORCERY_SSH_TUI=${lib.getExe pkg.sorcery-ssh-tui} SORCERY_REPOSITORIES=${cfg.repositories} SORCERY_CLONE_URL_BASE=${cfg.url_base}
        ForceCommand ${lib.getExe pkg.sorcery-ssh}
    '';

    users = {
      groups.git.gid = config.ids.gids.git;
      users.git = {
        description = "git user";
        group = "git";
        uid = config.ids.uids.git;
        shell = pkgs.bashInteractive;
        openssh.authorizedKeys = config.users.users.julia.openssh.authorizedKeys;
      };
    };
  };
}
