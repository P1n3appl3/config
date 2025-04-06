{ pkgs, ... }: {
  home.shell.enableFishIntegration = true;

  programs = {
    fish = { enable = true;
      plugins = {
        # TODO:
        # pufferfish (!! !$ ..+ etc)
        # done
        # fish-you-should-use
        # colored-man-pages
        # fifc
        # fzf
        # autopair/pisces
        # git-worktree-switcher
      };
      # shellAliases = {
      #   cat = "bat";
      #   c = "clear";
      #   l = "eza --icons";
      #   ls = "l -l";
      #   tree = "l -T --git-ignore";
      # };
    };
          fzf.enable = true;
        atuin.enable = true;
       zoxide.enable = true;
       direnv.enable = true;
     starship.enable = true;

     wezterm.enableFishIntegration = true;
     ghostty.enableFishIntegration = true;
     kitty.shellIntegrationenableFishIntegration = true;
  };
}
