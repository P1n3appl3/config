{ pkgs, lib, ... }:
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
      plugins = with pkgs.fishPlugins; let
          mkPlugin = p: {
            inherit (p) src;
            name = "${p.pname}";
          };
        in
        (map mkPlugin [
          puffer # (!! !$ !* ..+)
          done
          fish-you-should-use
          colored-man-pages
          autopair # try pisces?
          # fzf or fzf.fish or fifc if default integration isn't enough
        ]);
      shellInitLast = "source ~/.config/fish/extra.fish";
    };

    # TODO: check if these are on by default
    ghostty.enableFishIntegration = true;
    kitty.shellIntegration.enableFishIntegration = true;

    fzf = let fd = "fd --mount --color=always"; in {
      enable = true;
      fileWidgetCommand = fd;
      changeDirWidgetCommand = "${fd} -td";
      defaultOptions = [
        "--reverse"
        "--bind=ctrl-z:ignore"
        "--preview-window=down"
        "--height=60%"
        "--inline-info"
        "--bind 'ctrl-p:change-preview-window(hidden|down)'"
        "--bind ctrl-r:first"
        "--bind alt-up:first"
        "--bind alt-down:last"
        "--bind shift-up:preview-page-up"
        "--bind shift-down:preview-page-down"
        "--bind ctrl-d:half-page-down"
        "--bind ctrl-u:half-page-up"
      ];
      fileWidgetOptions = [
        "--multi"
        "--height=80%"
        "--ansi"
        ''--preview "~/.config/zsh/preview.sh {}"''
        ''--bind "ctrl-/:reload(${fd} . / -H)"''
        ''--bind "ctrl-h:reload(${fd} . ~ -H)"''
        ''--bind "ctrl-w:reload(${fd})"''
      ];
      changeDirWidgetOptions = [
        "--ansi"
      ];
      colors.bg = lib.mkForce "#000000";
    };
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
    nix-index = {
      enableFishIntegration = false;
      enableBashIntegration = false;
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
