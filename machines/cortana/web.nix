{ config, ... }: {
  networking.firewall = {
    allowedTCPPorts = [
      22 69 # ssh
      80 443 # http(s)
      8080 # testing
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

    grafana = {
      enable = true; settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 9000;
          domain = "traffic.pineapple.computer";
        };
      };
    };

    # TODO: replace with rust-rpxy
    nginx = {enable = true; recommendedProxySettings = true; };
    nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
      locations."/" = { proxyPass = "http://127.0.0.1:8080"; proxyWebsockets = true; };
    };

    static-web-server = { enable = true;
      root = "/media/static"; # port 8787
      configuration.general = { health = true; directory-listing = true; };
    };

    atuin = { enable = true;
      path = "/atuin"; # TODO: is this needed
      port = 9001;
      openRegistration = true; # TODO: how to add my user statically?
    };

    syncthing = let home = "/home/joseph/"; in { enable = true;
      # port 8384 by default, /metrics for prometheus
      user = "myusername";
      dataDir = home + "Documents";
      configDir = home + ".config/syncthing";
      overrideDevices = true; overrideFolders = true;
      settings = {
        devices = {
          # "WOPR".id = "TODO";
          # "HAL".id = "TODO";
          "dragon".id = "5WZIGDB-A5E2YCO-VRHUCI7-6O2GPWN-3J6ONPW-IVBHUE5-VM5JHF2-J2277A2";
          "clu".id = "KK6IRAU-W7HRIGO-TJL7PNN-DRQCLID-4BBPHPH-IRY5TJY-G372KO6-F527XAB";
        };
        folders = {
          "notes" = {
            path = "/home/joseph/notes";
            devices = [ "dragon" "clu" ];
          };
          # "roms" = { };
          # "music" = { };
          # "recipes" = { };
        };
      };
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
