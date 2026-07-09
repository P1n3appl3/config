{ pkgs, config, lib, ... }: let
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

  age.secrets = {
    porkbun-api.file = ../../secrets/porkbun-api.age;
    porkbun-secret.file = ../../secrets/porkbun-secret.age;
    password.file = ../../secrets/cortana-service-password.age;
  };

    services = let home-config = config.home-manager.users.julia; in {
    caddy = { enable = true;
      configFile = home-config.lib.file.mkOutOfStoreSymlink
        (home-config.home.sessionVariables.CONF_DIR + "/machines/cortana/Caddyfile");
    };

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
          secret_key = "SW2YcwTIb9zpOOhoPsMm";
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
      user = "julia";
      dataDir = "/home/julia/syncthing";
      overrideDevices = true; overrideFolders = true;
      settings.options.localAnnounceEnabled = true;
      settings = {
        devices = {
             HAL.id = "ON6QDIA-Q76YZPP-2QDT5KI-DOJVPXS-6757LVB-P2FKJAS-LOMDKIW-JT36XQ6";
            WOPR.id = "R6XKQSK-3XE7J2H-LSELK56-HVO6PTF-5PX2HZP-775JTZO-ETP2BR3-5QZ6YAF";
          dragon.id = "6TN3KGX-JU2KQEA-B6VKVCK-AJFAWQG-W2CLE5Q-2WYDPEN-YV3YKXU-HJV6UQL";
        };
        folders = (builtins.mapAttrs (n: d: { path = "~/syncthing/${n}"; devices = d; }) {
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

    porkbun-ddns = { enable = true;
      secret-key = config.age.secrets.porkbun-secret.path;
      api-key = config.age.secrets.porkbun-api.path;
      ipv6 = true;
      domains = [ "pineapple.computer" "julia.blue" ];
    };
  };

  systemd.services = {
    rahul-gists = {
      description = "Grab rahuls gists (until he makes a blog)";
      startAt = "0 0 */2 * *"; # every 2 days
      path = with pkgs; [ bash gh jq sd ];
      script = ''
        ~/.local/bin/gist-rss \
          rrbutani rahul https://rahul.red > /media/static/feeds/rahul;
      '';
      serviceConfig = {
        User = "julia";
        Group = "users";
      };
    };

    rsspls = {
      description = "Extract rss feeds from web pages";
      startAt = "00,12:00"; # twice a day
      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.rsspls} -o /media/static/feeds";
        User = "julia";
        Group = "users";
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
        cp ${blogs} ${blogs_out}
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

  users.users.caddy.extraGroups = [ "julia" ];
}
