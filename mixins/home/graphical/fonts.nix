{ pkgs, lib, ... }: {
  gtk.font = { name = "Sans"; size = lib.mkDefault 12; };

  home.packages = with pkgs; [
    source-code-pro
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    comic-neue
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "Noto Sans Symbols"
        "Noto Sans Symbols 2"
        "Symbols Nerd Font"
        "Noto Serif"
        "Noto Sans Math"
        "Noto Serif CJK JP"
      ];
      sansSerif = [
        "Noto Sans Symbols"
        "Noto Sans Symbols 2"
        "Symbols Nerd Font"
        "Noto Sans"
        "Noto Sans Math"
        "Noto Sans CJK JP"
      ];
      monospace = [
        "Noto Sans Symbols"
        "Noto Sans Symbols 2"
        "Symbols Nerd Font"
        "Source Code Pro"
        "Noto Sans Mono CJK JP"
        "Noto Sans Math"
      ];
      emoji = [
        "Noto Color Emoji"
      ];
      # TODO: cursive comic-neue
    };
  };

  xdg.configFile."fontconfig/fonts.conf".text = ''
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
<alias> <family>cursive</family> <prefer>
        <family>Noto Color Emoji</family>
        <family>Symbols Nerd Font</family>
        <family>Comic Neue</family>
</prefer> </alias>
</fontconfig>
'';
}
