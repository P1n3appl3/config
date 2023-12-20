{ pkgs, config, inputs, myOverlays, ... }: {
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
  ];

  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
    libraspberrypi
    acme-sh
  ];

  services = {
    openssh = {
      enable = true; ports = [ 69 ];
      settings.PasswordAuthentication = false;
    };
    endlessh-go = {
      enable = true; port = 22; openFirewall = true;
      prometheus.enable = true;
      extraOptions = [ "-alsologtostderr"];
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

  home-manager = {
    extraSpecialArgs = { inherit inputs myOverlays; };
    users.joseph.imports = [
      ../../home-modules/common.nix
      ../../home-modules/linux.nix
      ../../home-modules/btrfs.nix
    ];
  };

  time.timeZone = "America/Los_Angeles";

  networking.hostName = "Cortana";
  networking.firewall.allowedTCPPorts = [ 80 443 8080 ]; # 22 and 69 auto-enabled
}
