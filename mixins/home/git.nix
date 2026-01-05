{ pkgs, ... }: {
  home.packages = with pkgs; [
    git-lfs # git-absorb git-branchless
    git-heatmap git-undeadname git-coauthor
    gh
    onefetch
    git-worktree-switcher
  ];

  programs = {
    git = { enable = true;
      includes = [{ path = "~/.config/git/extraConfig"; }];

      settings = {
        core = {
          editor = "nvim";
          autocrlf = "input";
          excludesfile = "~/.config/git/ignore";
        };
        submodule.recurse = true;
        commit.gpgsign = true;
        gpg.format = "ssh";
        log.date = "format:%m/%d/%y";
        branch.autosetuprebase = "always";
        http.cookiefile = "~/.config/git/cookies";
        init.defaultBranch = "main";
      };
    };

    delta = { enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = false;
        navigate = true;
      };
    };

    jujutsu = {
      enable = true;
    };
  };
}
