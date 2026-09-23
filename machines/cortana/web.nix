{ pkgs, config, lib, ... }: let
  email = "juliaryan3.14@gmail.com";
in {
  networking.firewall = {
    allowedTCPPorts = [
      22 28      # ssh
      80 443     # http(s)
      2283       # immich
      22000      # syncthing
      8080 8443  # testing
      8123 21063 # home-assistant
    ] ++ lib.lists.range 9000 9010 # testing
      ++ lib.lists.range 1714 1764; # kde connect
    allowedUDPPorts = [
      5353        # home-assistant
      22000 21027 # syncthing + discovery
    ]; 
  };

  age.secrets = {
    porkbun-api.file = ../../secrets/porkbun-api.age;
    porkbun-secret.file = ../../secrets/porkbun-secret.age;
    matter-hub.file = ../../secrets/home-assistant-matter-hub.age;
    password = {
      file = ../../secrets/cortana-service-password.age;
      group = "grafana"; mode = "660";
    };
    caddy-env.file = ../../secrets/caddy.age;
  };

  environment.systemPackages = with pkgs; [
    caddy
    prometheus.cli
  ];

  services = let home-config = config.home-manager.users.julia; in {
    caddy = { enable = true;
      configFile = home-config.lib.file.mkOutOfStoreSymlink
        (home-config.home.sessionVariables.CONF_DIR + "/machines/cortana/Caddyfile");
      environmentFile = config.age.secrets.caddy-env.path;
      # TODO: ipban or ratelimit?
      # package = pkgs.caddy.withPlugins { plugins = []; hash = ""; };
    };

    openssh = { enable = true;
      ports = [ 28 ];
      settings.PasswordAuthentication = false;
      # TODO: watch /run/utmp and export to prometheus, or just read ssh log?
    };

    endlessh-go = { enable = true;
      port = 22;
      prometheus = { enable = true; port = 9100; };
      extraOptions = [ "-alsologtostderr" "-geoip_supplier" "ip-api" ];
      # TODO: use maxmind csv for offline geoip (just download it manually)
    };

    grafana = { enable = true;
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 9001;
          domain = "stats.pineapple.computer";
        };
        security = {
          admin_email = "julia";
          admin_password = "$__file{${config.age.secrets.password.path}}";
          secret_key = "SW2YcwTIb9zpOOhoPsMm";
        };
      };
    };

    prometheus = { enable = true;
      exporters.node = {
        enable = true;
        enabledCollectors = [ "systemd" ];
        port = 9101;
      };
      scrapeConfigs = [{
        job_name = "prometheus";
        static_configs = [{ targets = [
          "localhost:2019" # caddy
          "localhost:9100" # endlessh
          "localhost:9101" # node
          "localhost:9003" # syncthing
          "localhost:9006" # harmonia
          # TODO: atuin
          # TODO: btrfs if it's not in node
          # TODO: home assistant
        ]; }];
      }];
    };

    atuin = { enable = true;
      port = 9002;
      openRegistration = true; # TODO: how to add my user statically?
    };

    syncthing = { enable = true;
      guiAddress = "127.0.0.1:9003";
      dataDir = "/syncthing";
      overrideDevices = true; overrideFolders = true;
      settings.options.localAnnounceEnabled = true;
      settings = {
        devices = {
             HAL.id = "ON6QDIA-Q76YZPP-2QDT5KI-DOJVPXS-6757LVB-P2FKJAS-LOMDKIW-JT36XQ6";
            WOPR.id = "R6XKQSK-3XE7J2H-LSELK56-HVO6PTF-5PX2HZP-775JTZO-ETP2BR3-5QZ6YAF";
          dragon.id = "6TN3KGX-JU2KQEA-B6VKVCK-AJFAWQG-W2CLE5Q-2WYDPEN-YV3YKXU-HJV6UQL";
        };
        folders = (builtins.mapAttrs (n: d: { path = "/syncthing/${n}"; devices = d; }) {
                notes = [ "HAL" "WOPR" "dragon" ];
                music = [ "HAL" "WOPR" "dragon" ];
              recipes = [ "HAL" "WOPR" "dragon" ];
             torrents = [ "HAL" "WOPR" ];
          screenshots = [ "HAL" "WOPR" ];
        });
        gui.insecureSkipHostcheck = true; # expose web dashboard
      };
    };

    pgadmin = { enable = true;
      port = 9004;
      initialEmail = email;
      initialPasswordFile = config.age.secrets.password.path;
      # TODO: disable admin password once http auth works
    };

    chhoto-url = { enable = true;
      settings = {
        site_url = "https://l.julia.blue";
        port = 9005;
        try_longer_slugs = true;
        public_mode = true;
      };
    };

    # TODO: hook up grafana dashboard from the repo
    harmonia.cache = { enable = true; settings.bind = "[::]:9006"; };

    immich = { # enable = true;
      # TODO: figure out how i'm gonna setup uploads, do initial immich-go takeout batch,
      # and configure public-proxy
      port = 9007;
      mediaLocation = "/photos";
      accelerationDevices = [ "/dev/dri/renderD128" ];
    };

    home-assistant = { enable = true;
      extraPackages = python3packages: with python3packages; [ gtts zlib-ng isal ];
      config.default_config = {};
    };
    home-assistant-matter-hub = { enable = true;
      settings.homeAssistantUrl = "https://home.julia.blue";
      accessTokenFile = config.age.secrets.matter-hub.path;
    };

    sorcery = { enable = true;
      name = "git.julia.blue";
      url_base = "https://git.julia.blue";
      repositories = "/git/public";
    };

    # TODO: vaultwarden

    porkbun-ddns = { enable = true;
      secret-key = config.age.secrets.porkbun-secret.path;
      api-key = config.age.secrets.porkbun-api.path;
      ipv6 = true;
      domains = [ "pineapple.computer" "julia.blue" ];
    };
  };

  systemd.services = {
    chhoto-url.environment = {
      slug_style = lib.mkForce "UNICODE";
      slug_length = lib.mkForce "2";
      CHHOTO_SQLITE_USE_WAL_MODE="True";
    };

    rahul-gists = {
      description = "Grab rahuls gists (until he makes a blog)";
      startAt = "0 0 */2 * *"; # every 2 days
      path = with pkgs; [ bash gh jq sd ];
      script = ''
        ~/.local/bin/gist-rss \
          rrbutani rahul https://rahul.red > /website/feeds/rahul;
      '';
      serviceConfig = { User = "julia"; Group = "users"; };
    };

    rsspls = {
      description = "Extract rss feeds from web pages";
      startAt = "00,12:00"; # twice a day
      serviceConfig = {
        ExecStart = "${lib.getExe pkgs.rsspls} -o /website/feeds";
        User = "julia"; Group = "users";
      };
    };

    rssfetch = let
      blogs = builtins.toFile "blogs.json" (builtins.toJSON (import ./blogs.nix));
    in {
      description = "Update https://julia.blue/read";
      startAt = "01,13:00"; # twice a day
      path = with pkgs; [ rssfetch jq zstd gzip ];
      script = let
        out = "/website/posts.json";
        blogs_out = "/website/blogs.json";
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
  };

  # caddy needs to read files in /home, /syncthing, and /git
  systemd.services = {
    caddy.serviceConfig.ProtectHome = lib.mkForce false;
  };
  users.users = {
    caddy.extraGroups = [ "users" "syncthing" "git" ];
    syncthing.homeMode = "750";
    julia = {
      homeMode = "750";
      extraGroups = [ "syncthing" "caddy" "immich" "git" "postgres" ];
    };
  };
}
