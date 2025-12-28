{ pkgs, lib, ... }: {
  gtk.font = { name = "Sans"; size = lib.mkDefault 12; };

  home.packages = with pkgs; [
    source-code-pro
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.symbols-only
    comic-neue
    inter
    mononoki
    monaspace
    pango.bin
    uiua386
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
        "Symbols Nerd Font Mono"
        "Source Code Pro"
        "Noto Sans Mono CJK JP"
        "Noto Sans Math"
      ];
      emoji = [
        "Noto Color Emoji"
      ];
    };
  };
}
