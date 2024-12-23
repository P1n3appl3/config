{ pkgs, ... }: {
  programs = {
    # TODO: show ally
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
 }
