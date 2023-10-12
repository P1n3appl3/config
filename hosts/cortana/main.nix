{ pkgs, inputs, config, ... } : {
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
  # TODO: add atuin and set bash/zsh to use mine
  services = {
    openssh = {
      enable = true; ports = [ 69 ];
      settings.PasswordAuthentication = false;
    };
    # hook up fail2ban: https://demu.red/blog/2019/04/endlessh-html-scoreboard/
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
