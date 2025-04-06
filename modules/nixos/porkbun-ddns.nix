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
      type = types.path; description = "A file containing your porkbun api key";
    };
    secret-key = lib.mkOption {
      type = types.path; description = "A file containing your porkbun secret key";
    };
    ttl = lib.mkOption {
      default = 21600;
      type = types.ints.unsigned;
      description = lib.mdDoc ''The [Time to Live](https://developers.cloudflare.com/dns/manage-dns-records/reference/ttl/) for new DNS records in seconds'';
    };
    frequency = lib.mkOption {
      default = "00/6:00";
      type = types.str;
      description = lib.mdDoc ''
        How often to run update the DNS records, specified as a [systemd calendar expression](https://www.freedesktop.org/software/systemd/man/latest/systemd.time.html#Calendar%20Events)
      '';
    };
  };

  # TODO: try using haylee's crate instead of the script:
  # https://docs.rs/porkbun-api/latest/porkbun_api/struct.CreateOrEditDnsRecord.html
  config = lib.mkIf cfg.enable {
    systemd.services.porkbun-ddns = {
      description = "Update porkbun DNS entry to point to this computer";
      path = with pkgs; [ xh jq ];
      startAt = cfg.frequency;
      script = ''
        endpoint=https://api.porkbun.com/api/json/v3
        api=apikey=`<${cfg.api-key}`
        secret=secretapikey=`<${cfg.secret-key}`
        ip=`xh post $endpoint/ping $api $secret -I | jq .yourIp -r`
        echo "Updating record(s) to point at $ip"
        edit() {
          echo $1:
          xh post $endpoint/dns/editByNameType/$1/A $api $secret \
            content=$ip ttl=${toString cfg.ttl} -I 2>/dev/null |
            jq -r 'if has("message") then .message else .status end'
        }
        for domain in ${builtins.concatStringsSep " " cfg.domains}; do
          edit $domain
        done
      '';
    };
  };
}
