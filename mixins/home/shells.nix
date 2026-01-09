{ pkgs, ... }:
{
  home = {
    shell = {
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
    packages = with pkgs; [
      # zsh
      zsh-syntax-highlighting
      zsh-autosuggestions
      nix-zsh-completions

      # bash
      blesh
    ];
  };

  programs = {
    fish = {
      enable = true;
      plugins =
        with pkgs.fishPlugins;
        let
          mkPlugin = p: {
            inherit (p) src;
            name = "${p.pname}";
          };
        in
        (map mkPlugin [
          puffer # (!! !$ ..+ etc)
          done
          fish-you-should-use
          colored-man-pages
          autopair # try pisces?
          # fzf or fzf.fish if default integration isn't enough
          # fifc
        ]);
      shellInitLast = "source ~/.config/fish/extra.fish";
    };

    # TODO: check if these are on by default
    ghostty.enableFishIntegration = true;
    kitty.shellIntegration.enableFishIntegration = true;

    fzf.enable = true;
    atuin = {
      enable = true;
      flags = [ "--disable-up-arrow" ];
    };
    zoxide = {
      enable = true;
      options = [ "--cmd j" ];
    };
    direnv.enable = true;
    starship.enable = true;
    pay-respects = {
      enable = true;
      options = [ "--nocnf" ];
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
  };
}
