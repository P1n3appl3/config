{ pkgs, self, myOverlays, inputs, config, ... }: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
    inputs.ragenix.darwinModules.default
    inputs.mac-app-util.darwinModules.default
  ];

  services = {
    openssh.enable = true;
    # karabiner-elements.enable = true; // installed manually for now q.q
  };

  system = {
    primaryUser = "julia";
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
    keyboard.enableKeyMapping = false; # obviated by karabiner
    defaults = {
      ".GlobalPreferences" = {
        "com.apple.sound.beep.sound" = "/System/Library/Sounds/Pop.aiff";
      };
      CustomUserPreferences = {
        "com.apple.dock" = {
          workspaces-auto-swoosh = false;
        };
      };
      NSGlobalDomain = {
        AppleFontSmoothing = 0;
        AppleInterfaceStyle = "Dark";
        AppleShowAllExtensions = true;
        InitialKeyRepeat = 12; KeyRepeat = 2;
        NSWindowShouldDragOnGesture = true;
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
        expose-group-apps = true;
        tilesize = 16;
        # disable all hot corners
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
      # unfortunately tap to drag causes click delay
      trackpad = { Clicking = true; Dragging = false; };
      # TODO: turn off gatekeeper/LSQuarantine(deprecated)
      # TODO: check if universalaccess.closeViewScrollWheelToggle is needed for external mouse
      # TODO: don't check binaries from any of my terminal emulators or zed
    };
  };

  # TODO: use this, configure autoUpdate and cleanup (maybe zap?)
  # homebrew = { enable = true;
  #   brews = [
  #     "signal-desktop"
  #     "linearmouse" "middlelcick" "sol" "quicksilver" "itsycal"
  #     "pearcleaner" "vial" "syncthing" "nheko"
  #     "fleet"
  #     "github" "sublime-merge" "sourcetree"
  #   ];
  # };

  home-manager = let home-module = ({ pkgs, ...}: {
    home.packages = with pkgs; [
      karabiner-elements.driver kanata-with-cmd skhd keycastr
      stats hidden-bar # itsycal # https://github.com/NixOS/nixpkgs/issues/377645
      meld
      utm
      duti
      coreutils # TODO: uutils?
      nixos-rebuild-ng # for deploying to Cortana

      obsidian
      kitty
      telegram-desktop
    ];

    dev.compilers = false;
    dev.debuggers = false;

    services = {
      # TODO: make module compatible with macos (so it can set up syncthing-tray)
      syncthing.enable = true;
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
        inputs.mac-app-util.homeManagerModules.default
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

  security.pam.services.sudo_local.touchIdAuth = true;

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
    enable = true;
    settings = {
      trusted-users = [ "root" "@admin" ];
      extra-experimental-features = [ "nix-command" "flakes" ];
      extra-platforms = [ "x86_64-darwin" "aarch64-darwin" ];
      # sandbox = true; # breaks fish plugins?
      builders-use-substitutes = true;
      # TODO: resolve https://github.com/nix-darwin/nix-darwin/issues/477
      builders = [
        "ssh-ng://builder@linux-builder aarch64-linux /etc/nix/builder_ed25519 4 - - - c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSUpCV2N4Yi9CbGFxdDFhdU90RStGOFFVV3JVb3RpQzVxQkorVXVFV2RWQ2Igcm9vdEBuaXhvcwo="
      ];
    };
    linux-builder.enable = true;
    registry.config.to = { type = "git";
      url = "file://" + config.home-manager.users.julia.home.sessionVariables.CONF_DIR;
    };
  };
  users.users.julia.home = "/Users/julia";
}
