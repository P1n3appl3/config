{ pkgs, ... }: {
  home = {
    homeDirectory = "/usr/local/google/home/pineapple";
    packages = with pkgs; [
      blesh
      power-profiles-daemon
    ];
  };

  programs = {
    wpaperd.settings = {
      HDMI-A-1.path = "~/images/waneella/portrait";
    };

    # to show ally:
    vim = { enable = true;
      plugins = with pkgs.vimPlugins; [
        fzf-vim
      ];
    };
    bash = {
      enable = true;
      bashrcExtra = ''
      source $(blesh-share)/ble.sh
      if [ -d "$HOME/.local/bin" ] ; then
          PATH="$HOME/.local/bin:$PATH"
      fi

      if [ -d "$HOME/.nix-profile/bin" ] ; then
          PATH="$HOME/.nix-profile/bin:$PATH"
      fi'';
      shellAliases = {
        cat = "bat";
        c = "clear";
        l = "eza --icons";
        ls = "l -l";
        tree = "l -T --git-ignore";
      };
    };
          fzf = { enable = true; enableBashIntegration = true; };
        atuin = { enable = true; enableBashIntegration = true; };
       zoxide = { enable = true; enableBashIntegration = true; };
     starship = { enable = true; enableBashIntegration = true; };
  };

  services.kanshi = { enable = true;
    settings = [
      {
        profile.name = "undocked"; profile.outputs = [
          { criteria = "eDP-1"; mode = "3840x2160"; scale = 2.0; }
        ];
      }
      {
        profile.name = "docked"; profile.outputs = [
          {
            criteria = "DP-1";
            position = "0,0";
            mode = "3840x2160";
            scale = 1.5;
          }
          {
            position = "3840,0";
            criteria = "eDP-1";
            status = "enable";
            scale = 2.0;
          }
        ];
      }
    ];
  };

  dev.compilers = false;

  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/dev.nix
    ../mixins/home/work.nix
    ../mixins/home/graphical/common.nix
    ../mixins/home/graphical/sway.nix
    ../mixins/home/graphical/music.nix
  ];
}
