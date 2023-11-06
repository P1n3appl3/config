{ pkgs, inputs, config, ... }: {
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users.joseph = {
      imports = [
        ../../home-modules/common.nix
        ../../home-modules/linux.nix
        ../../home-modules/btrfs.nix
      ];
    };
  };

  # TODO: rust-motd + cats

  networking.hostName = "Cortana";
  networking.firewall.allowedTCPPorts = [ 80 443 8080 ];
  # TODO: add dnsmasq addblock + https://github.com/google/dnsmasq_exporter
  # or https://github.com/mokeyish/smartdns-rs
  # https://www.imaginaryrobots.net/posts/2022-01-26-full-network-adblocking-with-dnsmasq/
  # TODO: add rust rpxy for all the following, add prometheus output for grafana
  # https://github.com/junkurihara/rust-rpxy/blob/9123ef71a2da473f7c47ca5a21f1a787fca6c540/TODO.md?plain=1#L20
  # TODO: add atuin sync server and set bash/zsh to use mine
  # TODO: add gpodder and configure desktop client and antenna to use it
  # TODO: add recipe sage or tandoor recipes and move ours over
  # TODO: add syncthing introducer with static config and fallback relay or just MxN
  #  and prometheus metrics hookup!
  # TODO: https://jade.fyi/blog/docs-tricks-and-gnus/
  # TODO: friends.nix (authorizedkeys)
  services = {
    openssh = {
      enable = true; ports = [ 69 ];
      settings.PasswordAuthentication = false;
    };
    # hook up fail2ban: https://demu.red/blog/2019/04/endlessh-html-scoreboard/
    # use local geoip database: https://dev.maxmind.com/geoip/geolite2-free-geolocation-data
    endlessh-go = {
      enable = true; port = 22; openFirewall = true;
      prometheus.enable = true;
      extraOptions = [ "-alsologtostderr"]; # TODO: troubleshoot "-geoip_supplier ip-api"
    };
    grafana = {
      enable = true; settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 8080;
          domain = "traffic.pineapple.computer";
        };
      };
    };
    nginx = {enable = true; recommendedProxySettings = true; };
    nginx.virtualHosts.${config.services.grafana.settings.server.domain} = {
      locations."/" = { proxyPass = "http://127.0.0.1:8080"; proxyWebsockets = true; };
    };
  };

  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
    libraspberrypi
    acme-sh
  ];
}
