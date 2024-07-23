{ pkgs, ... }: {
  home = {
    homeDirectory = "/usr/local/google/home/pineapple";
    packages = with pkgs; [
      git-gr
      gn
    ];
  };

  programs.kitty.settings.font_size = 14;

  services.shpool = { enable = true;
    config.prompt_prefix = "";
  };

  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/btrfs.nix
    ../mixins/home/dev.nix
    ../mixins/home/work.nix
    ../mixins/home/graphical/common.nix
    ../mixins/home/graphical/sway.nix
  ];
}
