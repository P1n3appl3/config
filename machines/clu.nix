{ pkgs, ... }: {
  home.packages = with pkgs; [
    pastel
  ];

  programs.kitty.settings.font_size = 14;

  imports = [
    ../mixins/home/linux.nix
    ../mixins/home/dev.nix
    ../mixins/home/work.nix
    ../mixins/home/graphical/common.nix
    ../mixins/home/graphical/sway.nix
    ../mixins/home/graphical/music.nix
  ];
}
