{ pkgs, config, ... }: let
  acme_dir = "/var/lib/acme/pineapple.computer/";
in {
  networking.firewall = {
    allowedTCPPorts = [
      22 69 # ssh
      80 443 # http(s)
      8080 8443 # testing
      22000 # syncthing
    ];
    allowedUDPPorts = [ 22000 21027 ]; # syncthing + discovery
  };

  services = {
    openssh = {
      enable = true; ports = [ 69 ];
      settings.PasswordAuthentication = false;
      # TODO: watch /run/utmp and export to prometheus, or just read ssh log?
    };

    endlessh-go = {
      enable = true; port = 22;
      prometheus = { enable = true; port = 9100; };
      extraOptions = [ "-alsologtostderr"];
    };

    rust-rpxy = { enable = true;
      config = let
        tls = {
          https_redirection = true;
          tls_cert_path = acme_dir + "fullchain.pem";
          tls_cert_key_path = acme_dir + "key.pem";
        };
        proxy = port: [{ upstream = [{ location = "localhost:" + toString port; }]; }];
        app = name: port: { inherit tls; server_name = name; reverse_proxy = proxy port; };
      in {
        listen_port = 80;
        listen_port_tls = 443;
        listen_ipv6 = true;
        apps = {
          static    = app        "pineapple.computer" 9000;
          grafana   = app "status.pineapple.computer" 9001;
          atuin     = app  "atuin.pineapple.computer" 9002;
          syncthing = app   "sync.pineapple.computer" 9003;
          uptime    = app "uptime.pineapple.computer" 9004;
        };
        experimental.h3 = {};
      };
    };

    static-web-server = { enable = true;
      root = "/media/static";
      listen = "[::]:9000";
      configuration.general = { health = true; directory-listing = true; };
    };

    grafana = {
      enable = true; settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 9001;
          domain = "traffic.pineapple.computer";
        };
      };
    };

    atuin = { enable = true;
      # path = "/atuin"; # TODO: is this needed
      port = 9002;
      openRegistration = true; # TODO: how to add my user statically?
    };

    syncthing = { enable = true;
      # port 8384 by default, /metrics for prometheus
      guiAddress = "127.0.0.1:9003";
      overrideDevices = true; overrideFolders = true;
      settings.options.localAnnounceEnabled = true;
      settings = {
        devices = {
           # HAL.id = "TODO";
            WOPR.id = "N7B4EPQ-B3PLQIZ-NZIGIEC-CDOIZ3B-MLMUIIO-M5SGMJC-JTVRMB3-SUVIVQI";
             clu.id = "KK6IRAU-W7HRIGO-TJL7PNN-DRQCLID-4BBPHPH-IRY5TJY-G372KO6-F527XAB";
          dragon.id = "5WZIGDB-A5E2YCO-VRHUCI7-6O2GPWN-3J6ONPW-IVBHUE5-VM5JHF2-J2277A2";
        };
        folders = (builtins.mapAttrs (n: d: { path = "~/${n}"; devices = d; }) {
                notes = [ "WOPR" "dragon" "clu" ];
                music = [ "WOPR" "dragon" "clu" ];
              recipes = [ "WOPR" "dragon" ];
          screenshots = [ "WOPR" ];
        });
      };
    };

    uptime-kuma = { enable = true;
      settings.PORT = "9004";
    };
  };

  age.secrets = {
    porkbun-api.file = ../../secrets/porkbun-api.age;
    porkbun-secret.file = ../../secrets/porkbun-secret.age;
  };

  security.acme = { acceptTerms = true;
    certs."pineapple.computer" = {
      dnsProvider = "porkbun";
      renewInterval = "weekly";
      email = "josephryan3.14@gmail.com";
      extraDomainNames = [
        "josephis.gay" "josephryan.me"
        "*.pineapple.computer" "*.josephis.gay" "*.josephryan.me"
      ];
      environmentFile = builtins.toFile "envFile" "LEGO_DISABLE_CNAME_SUPPORT=true";
      credentialFiles = {
        "PORKBUN_API_KEY_FILE" = config.age.secrets.porkbun-api.path;
        "PORKBUN_SECRET_API_KEY_FILE" = config.age.secrets.porkbun-secret.path;
      };
    };
  };

  systemd.services = {
    convert-pem = let parent = [ "acme-pineapple.computer.service" ]; in {
      enable = true;
      description = "Convert LetsEncrypt private key from PKCS1 to PKCS8";
      unitConfig = { Type = "oneshot"; };
      serviceConfig = {
        ExecStart = ''${pkgs.openssl}/bin/openssl pkcs8 -topk8 -nocrypt \
          -in ${acme_dir}/key.pem -inform PEM \
          -out ${acme_dir}/key-pkcs8.pem -outform PEM'';
      };
      after = parent; wantedBy = parent;
    };

    ddns = {
      path = with pkgs; [ xh jq ];
      startAt = "*/6:00";
      script = ''
        endpoint=https://api.porkbun.com/api/json/v3
        edit=dns/editByNameType/pineapple.computer/A
        api=apikey=`<${config.age.secrets.porkbun-api.path}`
        secret=secretapikey=`<${config.age.secrets.porkbun-secret.path}`
        ip=`xh post $endpoint/ping $api $secret | jq .yourIp -r`
        xh post $endpoint/$edit $api $secret content=$ip ttl=21600 | jq .status -r
      '';
    };
  };
}
