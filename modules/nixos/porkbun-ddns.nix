{ config, lib, pkgs, ... }: let
  cfg = config.services.porkbun-ddns;
  types = lib.types;
in {
  options.services.porkbun-ddns = {
    enable = lib.mkEnableOption ''
      Simple Dynamic DNS client for porkbun that points domains at your current ip
    '';
    domains = lib.mkOption {
      type = types.listOf types.str;
      description = "A list of domain names to update the DNS entries for";
    };
    api-key = lib.mkOption {
      type = types.path;
      description = "A file containing your porkbun api key";
    };
    secret-key = lib.mkOption {
      type = types.path;
      description = "A file containing your porkbun api secret";
    };
    ipv4 = lib.mkOption {
      type = types.bool;
      description = "Set A records for your domain(s)";
      default = true;
    };
    ipv6 = lib.mkOption {
      type = types.bool;
      description = "Set AAAA records for your domain(s)";
    };
    ttl = lib.mkOption {
      default = 21600;
      type = types.ints.unsigned;
      description = lib.mdDoc "The [Time to Live](https://developers.cloudflare.com/dns/manage-dns-records/reference/ttl/) for new DNS records in seconds";
    };
    frequency = lib.mkOption {
      default = "00/6:00";
      type = types.str;
      description = lib.mdDoc ''
        How often to run update the DNS records, specified as a [systemd calendar expression](https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events)
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.porkbun-ddns = {
      description = "Update porkbun DNS entry to point to this computer";
      startAt = cfg.frequency;
      script = ''
        PORKBUN_API_KEY=`<${cfg.api-key}`
        PORKBUN_API_SECRET=`<${cfg.secret-key}`
        ${lib.getExe pkgs.porkbun-ddns} \
            ${if cfg.ipv4 then "-4" else ""} \
            ${if cfg.ipv6 then "-6" else ""} \
            --ttl ${cfg.ttl} \
            ${builtins.concatStringsSep " " cfg.domains}'';
    };
  };
}
