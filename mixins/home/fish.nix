{ pkgs, ... }: {
  home.shell.enableFishIntegration = true;

  programs = {
    fish = { enable = true;
      plugins = with pkgs.fishPlugins;
        let mkPlugin = p: { inherit (p) src; name = "${p.pname}"; }; in
      (map mkPlugin [
        puffer # (!! !$ ..+ etc)
        done
        fish-you-should-use
        colored-man-pages
        autopair # try pisces?
        # fzf or fzf.fish if default integration isn't enough
        # fifc
     ]);
    };
          fzf.enable = true;
        atuin.enable = true;
       zoxide.enable = true;
       direnv.enable = true;
     starship.enable = true;

     ghostty.enableFishIntegration = true;
     kitty.shellIntegration.enableFishIntegration = true;
  };
}
