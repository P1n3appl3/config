{ pkgs, self, myOverlays, inputs, config, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.ragenix.darwinModules.default
    # TODO: friends?
  ];

  services = {
    # TODO: re-enable when https://github.com/LnL7/nix-darwin/issues/1041 is resolved
    # karabiner-elements.enable = true;
    openssh.enable = true;
  };

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
      NSGlobalDomain = {
        AppleFontSmoothing = 0;
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 12; KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticInlinePredictionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSDocumentSaveNewDocumentsToCloud = false;
        "com.apple.mouse.tapBehavior" = 1; # how does this interact with trackpad setting?
      };
      alf = {
        allowdownloadsignedenabled = 1;
        allowsignedenabled = 1;
      };
      controlcenter = {
        BatteryShowPercentage = true;
        Display = true;
        FocusModes = true;
        NowPlaying = true;
        Sound = true;
      };
      dock = {
        autohide = true;
        mineffect = "suck";
        slow-motion-allowed = true;
        tilesize = 16;
        wvous-tl-corner = 1; wvous-tr-corner = 1;
        wvous-bl-corner = 1; wvous-br-corner = 1;
      };
      finder = {
        CreateDesktop = false;
        FXEnableExtensionChangeWarning = false;
        FXRemoveOldTrashItems = true;
        FXPreferredViewStyle = "clmv";
        _FXSortFoldersFirst = true;
        QuitMenuItem = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      hitoolbox.AppleFnUsageType = "Do Nothing"; # using as hyper key
      # menuExtraClock = {
      #   IsAnalog = true;
      #   ShowDate = 0; # when space allows
      #   ShowDayOfWeek = true;
      # };
      screencapture = {
        location = "/Users/julia/Pictures/screenshots";
        disable-shadow = true;
      };
      ActivityMonitor = {
        IconType = 6; # cpu usage history
        SortColumn = "CPUUsage";
      };
      trackpad = { Clicking = true; Dragging = true; };
      # TODO: turn off gatekeeper/LSQuarantine(deprecated)
      # TODO: check if universalaccess.closeViewScrollWheelToggle is needed for external mouse
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

    xdg.enable = true;
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

  fonts.packages = with pkgs; [ # TODO: share with ../mixins/home/fonts
    source-code-pro
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    nerd-fonts.symbols-only
    comic-neue
    inter
    mononoki
  ];

  security.pam.enableSudoTouchIdAuth = true;

  networking = {
    knownNetworkServices = [ "Thunderbolt Ethernet Slot 0" "Thunderbolt Bridge" "Wi-Fi" ];
    dns = [ "1.1.1.1" "8.8.8.8" ];
    computerName = "GLaDOS"; hostName = "GLaDOS";
  };

  nixpkgs = {
    overlays = myOverlays;
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };
  nix = {
    # TODO: still generate config file from here... or just get off determinate nix daemon
    enable = false;
    # settings = {
    #   trusted-users = [ "root" "@admin" ];
    #   extra-experimental-features = [ "nix-command" "flakes" ];
    #   extra-platforms = [ "x86_64-darwin" "aarch64-darwin" ]
    # };
    # registry.config.to = { type = "git";
    #   url = "file://" + config.home-manager.users.julia.home.sessionVariables.CONF_DIR;
    # };
    # linux-builder.enable = true;
  };
  users.users.julia.home = "/Users/julia";
}
