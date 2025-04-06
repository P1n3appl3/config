{ pkgs, ... }: {
  home.packages = with pkgs; [
    blesh
  ];

  home.shell.enableBashIntegration = true;

  programs = {
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
         fzf.enable = true;
       atuin.enable = true;
      zoxide.enable = true;
      direnv.enable = true;
    starship.enable = true;

    wezterm.enableBashIntegration = true;
    ghostty.enableBashIntegration = true;
    kitty.shellIntegration.enableBashIntegration = true;
  };
}
