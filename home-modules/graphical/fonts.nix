{ pkgs, lib, ... }: {
  fonts.fontconfig.enable = true;
  # TODO: verify that this is using noto
  gtk.font = { name = "Sans"; size = lib.mkDefault 12; };

  home.packages = with pkgs; [
    # TODO: look into opentype options with opentype.dev or other fonts:
    # dejavu victor menlo/meslo fira hack hasklig isoveka
    # jetbrains mononoki ubuntu (and check chat thread from work)
    source-code-pro
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    comic-neue

    fontfor
  ];

  # TODO: possibly grab this out of osConfig after making a nixos font module
  xdg.configFile."fontconfig/fonts.conf".text = ''
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
    <alias> <family>serif</family> <prefer>
        <family>Noto Sans Symbols</family>
        <family>Noto Sans Symbols 2</family>
        <family>Noto Color Emoji</family>
        <family>Symbols Nerd Font</family>
        <family>Noto Serif</family>
        <family>Noto Sans Math</family>
        <family>Noto Serif CJK JP</family>
    </prefer> </alias>
    <alias> <family>sans-serif</family> <prefer>
        <family>Noto Sans Symbols</family>
        <family>Noto Sans Symbols 2</family>
        <family>Noto Color Emoji</family>
        <family>Symbols Nerd Font</family>
        <family>Noto Sans</family>
        <family>Noto Sans Math</family>
        <family>Noto Sans CJK JP</family>
    </prefer> </alias>
    <alias> <family>monospace</family> <prefer>
        <family>Noto Sans Symbols</family>
        <family>Noto Sans Symbols 2</family>
        <family>Noto Color Emoji</family>
        <family>Symbols Nerd Font</family>
        <family>Source Code Pro</family>
        <family>Noto Sans Mono CJK JP</family>
        <family>Noto Sans Math</family>
    </prefer> </alias>
    <alias> <family>cursive</family> <prefer>
        <family>Noto Color Emoji</family>
        <family>Symbols Nerd Font</family>
        <family>Comic Neue</family>
    </prefer> </alias>
    <match>
        <test name="family"> <string>monospace</string> </test>
        <edit mode="prepend" name="family"> <string>Noto Color Emoji</string> </edit>
    </match>
</fontconfig>
'';
}
