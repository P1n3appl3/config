{ pkgs, self, myOverlays, inputs, config, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.ragenix.darwinModules.default
    # TODO: friends?
  ];

  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
    keyboard = { enableKeyMapping = true;
      swapLeftCtrlAndFn = true;
      remapCapsLockToEscape = true;
    };
    defaults = {
      ".GlobalPreferences" = {
        "com.apple.sound.beep.sound" = "/System/Library/Sounds/Pop.aiff";
      };
      "NSGlobalDomain" = {

      };
      ActivityMonitor = {
        IconType = 6; # cpu usage history
        SortColumn = "CPUUsage";
      };
      trackpad = { Clicking = true; Dragging = true; };
      # TODO: turn off gatekeeper/LSQuarantine(deprecated)
    };
  };

  home-manager = let home-module = ({ pkgs, ...}: {
    home.packages = with pkgs; [
      obsidian
      # vial # TODO: configure keyboard
      telegram-desktop signal-desktop
    ];
    services = {
      syncthing = { enable = true;
        # tray = { enable = true; command = "syncthingtray --wait"; };
      };
    };
  }); in {
    useGlobalPkgs = true;
    users.julia = {
      imports = [
        home-module
        ../mixins/home/common.nix
        ../mixins/home/dev.nix
        ../mixins/home/graphical/terminal.nix
      ] ++ builtins.attrValues self.outputs.homeModules;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  nixpkgs = {
    overlays = myOverlays;
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };
  nix = {
    # TODO: still generate config file from here... or just get off determinate nix daemon
    enable = false;
    settings = {
      trusted-users = [ "root" "@admin" ];
      extra-experimental-features = [ "nix-command" "flakes" ];
    };
    registry.config.to = { type = "git";
      url = "file://" + config.home-manager.users.julia.home.sessionVariables.CONF_DIR;
    };
  };
  users.users.julia.home = "/Users/julia";
}
