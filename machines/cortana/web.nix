{ pkgs, config, ... }: let
  acme_dir = "/var/lib/acme/pineapple.computer/";
  email = "juliaryan3.14@gmail.com";
in {
  networking.firewall = {
    allowedTCPPorts = [
      22 28     # ssh
      80 443    # http(s)
      22000     # syncthing
      8080 8443 # testing
      9000 9001 9002 9003 9004 # testing
    ];
    allowedUDPPorts = [ 22000 21027 ]; # syncthing + discovery
  };

  services = {
    openssh = { enable = true;
      ports = [ 28 ];
      settings.PasswordAuthentication = false;
      # TODO: watch /run/utmp and export to prometheus, or just read ssh log?
    };

    endlessh-go = { enable = true;
      port = 22;
      prometheus = { enable = true; port = 9100; };
      extraOptions = [ "-alsologtostderr"];
    };

    # TODO: prometheus export with tracing opentelemetry
    # TODO: custom http 503 error page
    rust-rpxy = { enable = true;
      config = let
        tls-dns = {
          https_redirection = true;
          tls_cert_path = acme_dir + "fullchain.pem";
          tls_cert_key_path = acme_dir + "key-pkcs8.pem";
        };
        tls-https = { https_redirection = true; acme = true; };
        proxy = port: [{ upstream = [{ location = "localhost:" + toString port; }]; }];
        app = name: port: { tls = tls-dns; server_name = name; reverse_proxy = proxy port; };
      in {
        listen_port = 80;
        listen_port_tls = 443;
        listen_ipv6 = true;
        default_app = "julia.blue";
        experimental.acme.email = email;
        apps = {
          static    = app                "julia.blue" 9000;
          static2   =(app         "julia.is.fckn.gay" 9000) // { tls = tls-https; };
          static3   =(app      "xn--ni8h.is.fckn.gay" 9000) // { tls = tls-https; };
          grafana   = app        "pineapple.computer" 9001;
          atuin     = app  "atuin.pineapple.computer" 9002;
          syncthing = app   "sync.pineapple.computer" 9003;
          uptime    = app "uptime.pineapple.computer" 9004;
        };
      };
    };

    # TODO: prometheus
    # https://github.com/static-web-server/static-web-server/pull/306
    static-web-server = { enable = true;
      root = "/media/static";
      listen = "[::]:9000";
      configuration.general = {
        health = true;
        directory-listing = true;
        compression-static = true;
      };
    };

    grafana = { enable = true;
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 9001;
          domain = "traffic.pineapple.computer";
        };
        security = {
          admin_email = email;
          admin_password = "$__file{${config.age.secrets.password.path}}";
        };
      };
    };

    # TODO: add btrfs
    prometheus = {
      exporters.node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9101;
      };
      scrapeConfigs = [{
        job_name = "prometheus";
        static_configs = [{ targets = [ "localhost:9100" "localhost:9101" ]; }];
      }];
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
             HAL.id = "ON6QDIA-Q76YZPP-2QDT5KI-DOJVPXS-6757LVB-P2FKJAS-LOMDKIW-JT36XQ6";
            WOPR.id = "R6XKQSK-3XE7J2H-LSELK56-HVO6PTF-5PX2HZP-775JTZO-ETP2BR3-5QZ6YAF";
          dragon.id = "6TN3KGX-JU2KQEA-B6VKVCK-AJFAWQG-W2CLE5Q-2WYDPEN-YV3YKXU-HJV6UQL";
        };
        folders = (builtins.mapAttrs (n: d: { path = "~/${n}"; devices = d; }) {
                notes = [ "HAL" "WOPR" "dragon" ];
                music = [ "HAL" "WOPR" "dragon" ];
              recipes = [ "HAL" "WOPR" "dragon" ];
             torrents = [ "HAL" "WOPR" ];
          screenshots = [ "HAL" "WOPR" ];
        });
        gui = {
          insecureSkipHostcheck = true;
          # password = config.age.secrets.password; // TODO: no way to pass this?
        };
      };
    };

    # TODO: replace with grafana page
    uptime-kuma = { enable = true;
      settings.PORT = "9004";
    };

    porkbun-ddns = { enable = true;
      secret-key = config.age.secrets.porkbun-secret.path;
      api-key = config.age.secrets.porkbun-api.path;
      domains = [ "pineapple.computer" "julia.blue" ];
    };
  };

  age.secrets = {
    porkbun-api.file = ../../secrets/porkbun-api.age;
    porkbun-secret.file = ../../secrets/porkbun-secret.age;
    password.file = ../../secrets/cortana-service-password.age;
  };

  security.acme = { acceptTerms = true;
    certs."pineapple.computer" = {
      dnsProvider = "porkbun";
      renewInterval = "weekly";
      inherit email;
      extraDomainNames = [
        "pineapple.computer"
        "*.pineapple.computer"
        "julia.blue"
        "*.julia.blue"
      ];
      extraLegoFlags = [ "--dns.propagation-disable-ans" ];
      environmentFile = builtins.toFile "envFile" "LEGO_DISABLE_CNAME_SUPPORT=true";
      credentialFiles = {
        "PORKBUN_API_KEY_FILE" = config.age.secrets.porkbun-api.path;
        "PORKBUN_SECRET_API_KEY_FILE" = config.age.secrets.porkbun-secret.path;
      };
    };
  };

  systemd.services = {
    convert-pem = let parent = [ "acme-pineapple.computer.service" ]; in {
      description = "Convert LetsEncrypt private key from PKCS1 to PKCS8";
      unitConfig.Type = "oneshot";
      serviceConfig = {
        User = "acme"; Group = "acme";
        ExecStart = ''${pkgs.openssl}/bin/openssl pkcs8 -topk8 -nocrypt \
          -in ${acme_dir}/key.pem -inform PEM \
          -out ${acme_dir}/key-pkcs8.pem -outform PEM'';
      };
      after = parent; wantedBy = parent;
    };

    rahul-gists = {
      description = "Grab rahuls gists (until he makes a blog)";
      startAt = "0 0 */2 * *"; # every 2 days
      path = with pkgs; [ gh jq sd ];
      serviceConfig = {
        ExecStart = ''/home/julia/.local/bin/gist-rss \
          rrbutani rahul https://rahul.red > /media/static/feeds/rahul'';
        User = "julia";
        Group = "julia";
      };
    };

    rsspls = {
      description = "Extract rss feeds from web pages";
      startAt = "00,12:00"; # twice a day
      path = [ pkgs.rsspls ];
      serviceConfig = {
        ExecStart = "rsspls -o /media/static/feeds";
        User = "julia";
        Group = "julia";
      };
    };

    rssfetch = let
      blogs = builtins.toFile "blogs.json" (builtins.toJSON (import ./blogs.nix));
    in {
      description = "Update https://julia.blue/read";
      startAt = "01,13:00"; # twice a day
      path = with pkgs; [ rssfetch jq zstd gzip ];
      script = let
        out = "/media/static/posts.json";
        blogs_out = "/media/static/blogs.json";
      in ''
        ln -sf ${blogs} ${blogs_out}
        rssfetch <(jq '.[]' ${blogs} -c) |
          jq -sc '. |= sort_by(.date) | reverse' > ${out}
        zstd ${blogs} -f -10 -o ${blogs_out}.zst
        zstd ${out}   -f -10
        gzip -c ${blogs} > ${blogs_out}.gz
        gzip -c   ${out} >   ${out}.gz
      '';
    };

    reset-usb = {
      description = "Reset the usb hub and remount the usb drive";
      unitConfig.Type = "oneshot";
      path = with pkgs; [ uhubctl ];
      serviceConfig.ExecStart = ''
        uhubctl -l 2 -a cycle -d 1
        sleep 5
        mount /dev/disk/by-label/pi-usb /media";
      '';
    };
  };
}
