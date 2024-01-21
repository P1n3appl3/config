{ config, ... }: {
  networking.firewall = {
    allowedTCPPorts = [
      22 69 # ssh
      80 443 # http(s)
      8080 8443 # testing
      22000 # syncthing
    ];
    allowedUDPPorts = [ 22000 21027 ]; # syncthing discovery
  };

  services = {
    openssh = {
      enable = true; ports = [ 69 ];
      settings.PasswordAuthentication = false;
    };

    endlessh-go = {
      enable = true; port = 22;
      prometheus = { enable = true; port = 9001; };
      extraOptions = [ "-alsologtostderr"];
    };

    rust-rpxy = { enable = true;
      config = let
        tls = let acme_dir = "/var/lib/acme/pineapple.computer/"; in {
          https_redirection = true;
          tls_cert_path = acme_dir + "fullchain.pem";
          tls_cert_key_path = acme_dir + "key.pem";
        };
        proxy = port: [{ upstream = [{ location = "localhost:" + toString port; }]; }];
        app = name: port: { inherit tls; server_name = name; reverse_proxy = proxy port; };
      in {
        listen_port = 8080;
        listen_port_tls = 8443;
        listen_ipv6 = true;
        apps.localhost = {
          static    = app        "pineapple.computer" 9000;
          grafana   = app "status.pineapple.computer" 9001;
          atuin     = app  "atuin.pineapple.computer" 9002;
          syncthing = app   "sync.pineapple.computer" 9003;
          uptime    = app "uptime.pineapple.computer" 9004;
        };
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

    syncthing = let home = "/home/joseph/"; in { enable = true;
      # port 8384 by default, /metrics for prometheus
      guiAddress = "127.0.0.1:9003";
      user = "myusername";
      # dataDir = home + "Documents";
      # configDir = home + ".config/syncthing";
      overrideDevices = true; overrideFolders = true;
      settings = {
        devices = {
          # "HAL".id = "TODO";
            "WOPR".id = "N7B4EPQ-B3PLQIZ-NZIGIEC-CDOIZ3B-MLMUIIO-M5SGMJC-JTVRMB3-SUVIVQI";
             "clu".id = "KK6IRAU-W7HRIGO-TJL7PNN-DRQCLID-4BBPHPH-IRY5TJY-G372KO6-F527XAB";
          "dragon".id = "5WZIGDB-A5E2YCO-VRHUCI7-6O2GPWN-3J6ONPW-IVBHUE5-VM5JHF2-J2277A2";
        };
        folders = {
          "notes" = {
            path = home + "notes";
            devices = [ "WOPR" "dragon" "clu" ];
          };
          "music" = {
            path = home + "music/library";
            devices = [ "WOPR" "dragon" "clu" ];
          };
          # "roms" = { };
          # "recipes" = { };
          # "screenshots" = { };
          # "backgrounds" = { };
        };
      };
    };

    uptime-kuma = { enable = true;
      settings.PORT = "9004";
    };
  };

  security.acme = { acceptTerms = true;
    certs."pineapple.computer" = {
      dnsProvider = "porkbun";
      renewInterval = "weekly";
      email = "josephryan3.14@gmail.com";
      extraDomainNames = [ "*.pineapple.computer"
        "josephis.gay" "*.josephis.gay"
        "josephryan.me" "*.josephryan.me"
      ];
      credentialFiles = {
        "PORKBUN_API_KEY_FILE" = "/media/porkbun_api_key";
        "PORKBUN_SECRET_API_KEY_FILE" = "/media/porkbun_secret_key";
      };
    };
  };
}
