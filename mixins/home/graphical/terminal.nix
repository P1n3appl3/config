{ pkgs, lib, config, ... }: let nixGL = config.lib.nixGL.wrap; in {
  programs = {
    ghostty = { enable = pkgs.stdenv.isLinux;
      package = (nixGL pkgs.ghostty);
      installVimSyntax = true;
      settings = {
        font-size = lib.mkDefault 12;
        config-file = "common";
      };
    };
    wezterm = { enable = true;
      package = (nixGL pkgs.wezterm);
      extraConfig = "return require 'config'";
    };
    kitty = { enable = true;
      package = (nixGL pkgs.kitty);
      settings = {
        font_size = lib.mkDefault 12;
        include = "~/.config/kitty/common.conf";
      };
    };
  };
}
