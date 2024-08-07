{ lib, pkgs, ... }: {
  home = {
    username = "pineapple";
    packages = with pkgs; [
      shpool
    ];
  };

  xdg.mimeApps.defaultApplications =
    let chrome = lib.mkForce "google-chrome.desktop"; in {
    "text/html" = chrome;
    "x-scheme-handler/http" = chrome;
    "x-scheme-handler/https" = chrome;
  };

  systemd.user = {
    sessionVariables.SSH_AUTH_SOCK = ''''${XDG_RUNTIME_DIR}/ssh-agent.socket'';
    services.ssh-agent = {
      Unit.Description = "SSH key agent";
      Service = {
        Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
        ExecStart = "/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
